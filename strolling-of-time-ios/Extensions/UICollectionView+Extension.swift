//
//  UICollectionView+Extension.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

extension UICollectionView {
    func cell<T: UICollectionViewCell>(type cellType: T.Type, for indexPath: IndexPath) -> T where T: NibLoadable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.nibId, for: indexPath) as? T else {
            fatalError("Could not find cell with reuseID \(T.nibId)")
        }
        return cell
    }
}
