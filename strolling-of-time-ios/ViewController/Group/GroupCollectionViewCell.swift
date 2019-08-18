//
//  GroupCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/18.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var whiteActiveView: UIView!
    @IBOutlet weak var redActiveView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        self.profileImageView.makeRounded()
        self.whiteActiveView.makeRounded()
        self.redActiveView.makeRounded()
    }
    
    func configure(data: String) {
        self.nameLabel.text = data
        self.whiteActiveView.isHidden = data == "naljin"
    }
}
