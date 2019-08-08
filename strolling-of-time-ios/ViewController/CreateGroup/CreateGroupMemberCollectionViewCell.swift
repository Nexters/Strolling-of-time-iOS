//
//  CreateGroupMemberCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class CreateGroupMemberCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet private weak var memberImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memberImage?.makeRounded()
    }
    
    func configure(data: String) {
        memberImage?.image = UIImage(named: data)
    }
}
