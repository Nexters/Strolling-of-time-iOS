//
//  CreateGroupCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class CreateGroupCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        profileImage.makeRounded()
    }
}
