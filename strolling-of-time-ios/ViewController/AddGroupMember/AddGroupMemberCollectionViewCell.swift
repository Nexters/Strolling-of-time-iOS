//
//  AddGroupMemberCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/20.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class AddGroupMemberCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var cancelButton: UIButton!
    var deleteMemberBlock: ((_ row: Int) -> Void)?
    private var row: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setButtonAttr()
    }
    func configure(row: Int, data: (member: String, image: String, index: Int)){
        profileImage?.makeRounded()
        nameLabel?.text = data.member
        self.row = row
    }
    func setButtonAttr() {
        self.cancelButton.addTarget(self, action: #selector(deleteMember), for: .touchUpInside)
    }
    @objc func deleteMember() {
        deleteMemberBlock?(self.row ?? 0)
    }
    func setCallback(callback:@escaping (_ row: Int) -> Void) {
        deleteMemberBlock = callback
    }
}
