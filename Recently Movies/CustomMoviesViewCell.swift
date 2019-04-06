//
//  CustomTableViewCell.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class CustomMoviesViewCell: UITableViewCell {

    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
