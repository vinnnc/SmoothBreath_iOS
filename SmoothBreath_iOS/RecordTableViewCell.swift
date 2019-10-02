//
//  RecordTableViewCell.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/7.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var attackLevelLabel: UILabel!
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var nearbyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
