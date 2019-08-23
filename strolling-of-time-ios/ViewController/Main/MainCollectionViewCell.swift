//
//  MainCollectionViewCell.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/08.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memeberCountLabel: UILabel!
    var data: String?
    @IBOutlet weak var memeberIcon: UIImageView!
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 14)
    }
    
    func configure(data: String) {
        memeberCountLabel.isHidden = data == "전체"
        memeberIcon.isHidden = data == "전체"
        titleLabel.text = data
    }
    override var isSelected: Bool {
        didSet {
            if let data = self.data {
                if data == "전체" {
                    self.selectedView.backgroundColor = isSelected ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    self.selectedView.alpha = 1
                } else {
                    self.selectedView.backgroundColor = data == "2020 경찰 공무원" ? #colorLiteral(red: 1, green: 0.4103192091, blue: 0.5433492064, alpha: 1) : #colorLiteral(red: 0.1634896398, green: 0.6205129623, blue: 1, alpha: 1)
                    self.selectedView.alpha = isSelected ? 1 : 0
                }
            } else {
                //맨처음
                self.selectedView.backgroundColor = isSelected ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
    }
}
