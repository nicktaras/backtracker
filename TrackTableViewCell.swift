//
//  TrackTableViewCell.swift
//  Backtrack Mapper
//
//  Created by Nicholas Taras on 19/10/2016.
//  Copyright © 2016 Tea Break Apps. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
