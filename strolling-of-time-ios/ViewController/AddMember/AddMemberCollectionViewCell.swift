//
//  AddMemberCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class AddMemberCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var profileImage: UIImageView?
    @IBOutlet private weak var cancelButton: UIButton?
    
    func configure(data: (member: String, index: Int)){
        nameLabel?.text = data.member
    }
    
}
