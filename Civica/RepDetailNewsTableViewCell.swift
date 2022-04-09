//
//  RepDetailNewsTableViewCell.swift
//  Civica
//
//  Created by OSL on 4/2/22.
//

import UIKit

class RepDetailNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
