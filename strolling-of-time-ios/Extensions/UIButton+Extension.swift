//
//  UIButton+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UIButton {
    func setValidButton(isActive: Bool) {
        if isActive {
            self.isUserInteractionEnabled = true
            self.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.431372549, blue: 0.9098039216, alpha: 1)
            self.setTitleColor(.white, for: .normal)
        } else {
            self.isUserInteractionEnabled = false
            self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            self.setTitleColor(#colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1), for: .normal)
        }
    }
}
