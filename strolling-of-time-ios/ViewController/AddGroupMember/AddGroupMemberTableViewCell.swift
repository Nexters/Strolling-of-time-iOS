//
//  AddGroupMemberTableViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/20.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class AddGroupMemberTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var countLabel: UILabel?
    @IBOutlet private weak var profileImage: UIImageView?
    @IBOutlet private weak var checkImage: UIImageView?
    
    func configure(data: (member: String, image: String, index: Int)){
        profileImage?.makeRounded()
        nameLabel?.text = data.member
    }
}
