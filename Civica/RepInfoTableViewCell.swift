//
//  RepInfoTableViewCell.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit

class RepInfoTableViewCell: UITableViewCell {


    @IBOutlet weak var repImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var firstlineLabel: UILabel!
//    @IBOutlet weak var secondLabel: UILabel!

    @IBAction func moreinfoButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
