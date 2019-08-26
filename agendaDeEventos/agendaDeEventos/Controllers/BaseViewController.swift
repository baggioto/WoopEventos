//
//  BaseViewController.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 24/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationSettings()
    }
    
    func setNavigationSettings(){
        
        if let navigationColor: UIColor = UIColor.init(hexString: "#00E695"){
            self.navigationController?.navigationBar.barTintColor = navigationColor
        }
        if let navigationTintColor: UIColor = UIColor.white{
            self.navigationController?.navigationBar.tintColor = navigationTintColor
        }
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]

    }
    
    func sendMessageForCanelOnAlert(message:String){
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func downloadImage(from sentUrl: String, onImageView imageView:UIImageView){
        if let url = URL(string: sentUrl) {
            
            imageView.kf.setImage(with: url)
            
        }
    }
}
