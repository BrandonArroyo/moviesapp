//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Brandon Arroyo on 1/20/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var poserView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
