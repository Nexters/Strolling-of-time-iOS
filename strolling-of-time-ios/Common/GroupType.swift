//
//  GroupType.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

enum GroupType: String, CaseIterable {
    case study = "스터디"
    case exercise = "운동"
    case debate = "토론"
    case coding = "개발"
    case writing = "글쓰기"
    
    var color: UIColor {
        switch self {
        case .study:
            return #colorLiteral(red: 1, green: 0.3058823529, blue: 0.4705882353, alpha: 1)
        case .exercise:
            return #colorLiteral(red: 1, green: 0.8156862745, blue: 0.262745098, alpha: 1)
        case .debate:
            return #colorLiteral(red: 0.137254902, green: 0.8235294118, blue: 0.7450980392, alpha: 1)
        case .coding:
            return #colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 1, alpha: 1)
        case .writing:
            return #colorLiteral(red: 0.4039215686, green: 0.4392156863, blue: 1, alpha: 1)
        }
    }
    var ovalImage: UIImage {
        switch self {
        case .study:
            return #imageLiteral(resourceName: "ovalPink")
        default:
            return #imageLiteral(resourceName: "ovalBlack")
        }
    }
}
