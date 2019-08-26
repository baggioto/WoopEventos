//
//  DetailViewController.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 25/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: BaseViewController {
    
    var eventId: String!
    var event: Event!

    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var labelEventDescription: UILabel!
    @IBOutlet weak var checkinButton: UIButton!
    
    @IBAction func shareEvent(_ sender: Any) {
    
        if let event = self.event{
            if let image = event.image, let shareText = event.title {
                let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                present(vc, animated: true, completion: nil)
            }
        }else{
            self.changeScreenForError()
        }
    }
    
    @IBAction func doCheckIn(_ sender: Any) {
    
        let apiUrl = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin"
        
        //Call stayed mocked, but the correct way is to get the users' info(name and email) from the system,
        //probably a configuration file or preferences from the application
        
        if let event = self.event{
            
            Alamofire.request(apiUrl, method: .post, parameters: ["eventId": event.eventId, "name": "Otávio", "email": "otavio_souza@hotmail.com" ],encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                    
                    if let statusCode:Int = response.response?.statusCode{
                        
                        if(statusCode > 200 && statusCode<300){
                            
                            if let data  = response.data{
                                
                                let json = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                                
                                self.sendMessageForCanelOnAlert(message:"Check in feito com sucesso!")
                                print(response)
                                
                            }
                            
                        }else{
                            self.sendMessageForCanelOnAlert(message:"Erro ao tentar realizar check in. Por favor tente novamente.")
                            print("Erro de check in: " + String(statusCode))
                        }
                        
                    }else{
                        self.sendMessageForCanelOnAlert(message:"Erro ao tentar realizar check in. Por favor tente novamente.")
                        print("Erro de check in: Não foi possível obter código de retorno HTTP.")
                    }
                    
                    break
                case .failure(let error):
                    
                    self.sendMessageForCanelOnAlert(message:"Erro ao tentar realizar check in. Por favor tente novamente.")
                    print(error)
                    
                }
            }
        }else{
            self.changeScreenForError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        getEvent()
    }
    
    func setupButtons(){
        self.imageViewEvent.layer.cornerRadius = 20
        self.imageViewEvent.layer.masksToBounds = true
        self.imageViewEvent.layer.borderWidth = 2
        self.checkinButton.layer.cornerRadius = 10
    }
    
    func getEvent(){
        
        let apiUrl = String("http://5b840ba5db24a100142dcd8c.mockapi.io/api/events/" + self.eventId)
        
        Alamofire.request(URL(string:apiUrl )!).validate().responseJSON{ (response) in
            
                if(response.result.isSuccess){
                    
                    if let data  = response.data{
                    
                    let json: [String:Any] = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    
                    self.event = Event(with: json)
                    
                    self.title = self.event.title
                    
                    if let currentEventDescriptionLabel = self.labelEventDescription{
                        currentEventDescriptionLabel.text = self.event.eventDescription
                    }
                    
                    if let imageView = self.imageViewEvent{
                        self.downloadImage(from: self.event.image, onImageView: imageView)
                    }
                    
                    }else{
                        
                        self.changeScreenForError()
                        
                    }
                    
                }else{
                    
                    self.changeScreenForError()
                    
            }
        }
    }
    
    func changeScreenForError(){
        
        self.imageViewEvent.image = UIImage(named: "events_logo")
        self.labelEventDescription.isHidden = true
        self.sendMessageForCanelOnAlert(message:"Erro ao buscar evento junto ao servidor. Por favor tente novamente em breve.")
    }
    
}
