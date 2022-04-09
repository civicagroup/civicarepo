//
//  RepDetailTweetTableViewCell.swift
//  Civica
//
//  Created by OSL on 4/6/22.
//

import UIKit

class RepDetailTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
