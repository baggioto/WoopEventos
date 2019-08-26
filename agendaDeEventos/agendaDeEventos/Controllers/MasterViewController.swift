//
//  ViewController.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 24/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{

    var events: [Event]!
    var detailEventId: String!
    
    @IBOutlet weak var eventsLogoImageView: UIImageView!
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationbar()
        registerTableViewCells()
        setupTableView()
        getEvents()
    }
    
    func setupTableView(){
        self.eventTableView.tableFooterView = UIView(frame: .zero)
        self.eventTableView.separatorStyle = .none
    }
    
    func setNavigationbar(){
        let headerview : UIView = UIView()
        
        //used wrong icon name, for it's not centering on naviation bar, better leave the title
        if let navigationImage: UIImage = UIImage(named: "navigation_icons"){
            let imgView: UIImageView = UIImageView(image: navigationImage)
            
            imgView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imgView.frame.size.width, height: 25))
            imgView.contentMode = .scaleAspectFit
            
            headerview.frame = imgView.frame
            headerview.addSubview(imgView)
            
            self.navigationController?.navigationBar.topItem?.titleView = headerview
        }else{
            self.title = "Woop Eventos"
        }
    }
    
    func getEvents() {
        
        Alamofire.request(URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events")!).validate().responseJSON{ (response) in
            
            if let data  = response.data{
                
                if(response.result.isSuccess){
                    
                    let json: [[String:Any]] = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
                    
                    var events: [Event] = []
                    
                    for currentEvent in json{
                        
                        let correctEvent : Event = Event(with: currentEvent)
                        events.append(correctEvent)
                        
                    }
                    
                    self.events = events;
                    self.eventTableView.reloadData()
                    
                }else{
                    
                    self.sendMessageForCanelOnAlert(message:"Erro ao buscar eventos junto ao servidor. Por favor tente reiniciar a aplicação.")

                }
            }
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.events != nil){
            return self.events.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "EventCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EventCell
        
        downloadImage(from: self.events[indexPath.row].image, onImageView: cell.eventImageView)
        cell.eventLabel.text = self.events[indexPath.row].title
        
        return cell
        
    }
    
    func registerTableViewCells(){
        let reuseIdentifier = "EventCell"
        let eventCell = UINib(nibName: "EventCell", bundle: nil)
        self.eventTableView.register(eventCell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            if(identifier.elementsEqual("toDetailViewController")){
                let detailViewController:DetailViewController = segue.destination as! DetailViewController
                detailViewController.eventId = self.detailEventId
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(withEventId: self.events[indexPath.row].eventId)
    }
    
    func navigateToDetail(withEventId eventId:String){
        self.detailEventId = eventId
        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }

}

