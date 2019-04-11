//
//  ReviewTableViewCell.swift
//  Recently Movies
//
//  Created by jets on 8/3/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewName: UILabel!
    @IBOutlet weak var viewReview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
