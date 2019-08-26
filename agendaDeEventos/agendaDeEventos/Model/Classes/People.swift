//
//  People.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 24/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import Foundation

class People {
    var peopleId:String!
    var eventId:String!
    var name:String!
    var picture:String!
    
    init(with dictionary: [String: Any]?){
        guard let dictionary = dictionary else { return }
        
        self.peopleId = dictionary["id"] as? String
        self.eventId = dictionary["eventId"] as? String
        self.name = dictionary["name"] as? String
        self.picture = dictionary["picture"] as? String
        
    }
    
}
