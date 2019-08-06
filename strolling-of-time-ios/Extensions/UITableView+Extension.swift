//
//  UITableView+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UITableView {
    func cell<T: UITableViewCell>(for cellType: T.Type) -> T where T: NibLoadable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.nibId) as? T else {
            fatalError("Could not find cell with reuseID \(T.nibId)")
        }
        return cell
    }
}
