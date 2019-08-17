//
//  UICollectionViewCell+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func makeCornerRound(cornerRadius : CGFloat){
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true 
    }
}
