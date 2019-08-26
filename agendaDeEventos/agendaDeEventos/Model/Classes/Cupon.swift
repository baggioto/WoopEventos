//
//  Cupon.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 24/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import Foundation

class Cupon {
    var eventId:String!
    var dicount:Double!
    var cuponId:String!
    
    init(with dictionary: [String: Any]?){
        guard let dictionary = dictionary else { return }
        
        self.eventId = dictionary["eventId"] as? String
        self.dicount = dictionary["dicount"] as? Double
        self.cuponId = dictionary["id"] as? String
        
    }
}
