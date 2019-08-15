//
//  UIViewController+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/15.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UIViewController {
    func isIphoneX() -> Bool{
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("IPHONE 5,5S,5C")
                return false
            case 1334:
                print("IPHONE 6,7,8 IPHONE 6S,7S,8S ")
                return false
            case 1920, 2208:
                print("IPHONE 6PLUS, 6SPLUS, 7PLUS, 8PLUS")
                return false
            case 2436:
                print("IPHONE X, IPHONE XS")
                return true
            case 2688:
                print("IPHONE XS_MAX")
                return true
            case 1792:
                print("IPHONE XR")
                return true
            default:
                print("UNDETERMINED")
                return false
            }
        }
        return false
    }
}
