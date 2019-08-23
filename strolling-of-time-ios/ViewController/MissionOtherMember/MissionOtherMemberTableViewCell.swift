//
//  MissionOtherMemberTableViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/23.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MissionOtherMemberTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
