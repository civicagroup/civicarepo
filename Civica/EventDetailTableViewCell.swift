//
//  EventDetailTableViewCell.swift
//  Civica
//
//  Created by OSL on 4/20/22.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventOrganizer: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
