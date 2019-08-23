//
//  UIStoryboard+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func viewController<T>(_ type: T.Type) -> T where T: NibLoadable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.nibId) as? T else {
            fatalError("Could not find viewController \(T.nibId)")
        }
        return viewController
    }
}
