//
//  EventCell.swift
//  agendaDeEventos
//
//  Created by Felipe Baggioto on 24/08/2019.
//  Copyright © 2019 Felipe Baggioto. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.eventImageView.layer.cornerRadius = 0.5 * eventImageView.bounds.size.width
        self.eventImageView.layer.masksToBounds = true
        
//        if let borderColor:CGColor = (UIColor(hexString: "#A41CEC") as! CGColor){
//            self.eventImageView?.layer.borderColor = borderColor
//        }
        
        self.eventImageView.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
