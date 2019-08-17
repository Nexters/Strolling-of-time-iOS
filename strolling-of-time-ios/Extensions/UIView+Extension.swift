//
//  UIView+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UIView {
    func makeRounded(cornerRadius: CGFloat? = nil) {
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        } else {
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        self.layer.masksToBounds = true
    }
    func makeViewBorder(width: Double, color: UIColor) {
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    func makeRoundedSelectedCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
