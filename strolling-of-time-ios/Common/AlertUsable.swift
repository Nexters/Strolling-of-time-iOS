//
//  AlertUsable.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/08.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

protocol AlertUsable: UIPresentable {
    func simpleAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?)
}

extension AlertUsable {
    func simpleAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okTitle = "확인"
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
        alert.addAction(okAction)
        self.viewController.present(alert, animated: true)
    }
}
