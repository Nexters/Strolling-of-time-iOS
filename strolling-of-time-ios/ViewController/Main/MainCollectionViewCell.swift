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
    
    override func awakeFromNib() {
        self.makeRounded(cornerRadius: 14)
    }
    
    func configure(data: String) {
        memeberCountLabel.isHidden = data == "전체"
        titleLabel.text = data
    }
    override var isSelected: Bool {
        didSet {
            if let data = self.data {
                if data == "전체" {
                    self.selectedView.backgroundColor = isSelected ? UIColor.black : .gray
                    self.selectedView.alpha = 1
                } else {
                    self.selectedView.backgroundColor = data == "sujin" ? UIColor.blue : .red
                    self.selectedView.alpha = isSelected ? 1 : 0
                }
            } else {
                self.selectedView.backgroundColor = isSelected ? UIColor.black : .gray
            }
        }
    }
}
