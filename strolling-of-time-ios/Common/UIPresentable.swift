//
//  UIPresentable.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/08.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

protocol UIPresentable: class {
    var viewController: UIViewController { get }
}

extension UIPresentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
