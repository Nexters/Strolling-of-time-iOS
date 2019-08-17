//
//  KeyboardObserving.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

/// Conform to `KeyboardObserving` protocol in a view controller to observe UIKeyboard events.
protocol KeyboardObserving: class {
    /// Called when .UIKeyboardWillShow notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillShow notification.
    func keyboardWillShow(_ notification: Notification)
    /// Called when .UIKeyboardDidShow notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidShow notification.
    func keyboardDidShow(_ notification: Notification)
    /// Called when .UIKeyboardWillHide notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillHide notification.
    func keyboardWillHide(_ notification: Notification)
    /// Called when .UIKeyboardDidHide notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidHide notification.
    func keyboardDidHide(_ notification: Notification)
    /// Called when .UIKeyboardWillChangeFrame notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillChangeFrame notification.
    func keyboardWillChangeFrame(_ notification: Notification)
    /// Called when .UIKeyboardDidChangeFrame notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidChangeFrame notification.
    func keyboardDidChangeFrame(_ notification: Notification)
    /// Register for UIKeyboard notifications.
    func registerForKeyboardEvents()
    /// Unregister from UIKeyboard notifications.
    func unregisterFromKeyboardEvents()
}

extension KeyboardObserving where Self: UIViewController {
    /// Called when .UIKeyboardWillShow notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillShow notification.
    func keyboardWillShow(_ notification: Notification) {}
    /// Called when .UIKeyboardDidShow notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidShow notification.
    func keyboardDidShow(_ notification: Notification) {}
    /// Called when .UIKeyboardWillHide notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillHide notification.
    func keyboardWillHide(_ notification: Notification) {}
    /// Called when .UIKeyboardDidHide notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidHide notification.
    func keyboardDidHide(_ notification: Notification) {}
    /// Called when .UIKeyboardWillChangeFrame notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardWillChangeFrame notification.
    func keyboardWillChangeFrame(_ notification: Notification) {}
    /// Called when .UIKeyboardDidChangeFrame notification is prodcasted by system.
    ///
    /// - Parameter notification: .UIKeyboardDidChangeFrame notification.
    func keyboardDidChangeFrame(_ notification: Notification) {}
    /// Register for UIKeyboard notifications.
    func registerForKeyboardEvents() {
        _ = self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view,
                                                                  action: #selector(self.view.endEditing(_:))))
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { notification in
            self.keyboardDidShow(notification)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil) { notification in
            self.keyboardDidHide(notification)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { notification in
            self.keyboardWillChangeFrame(notification)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification, object: nil, queue: nil) { notification in
            self.keyboardDidChangeFrame(notification)
        }
    }
    /// Unregister from UIKeyboard notifications.
    func unregisterFromKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
}
