//
//  LoginViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NibLoadable, AlertUsable, KeyboardObserving {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBAction func login(_ sender: Any) {
        let email = emailTextField.text
        let pwd = pwdTextField.text
        self.login(email: email ?? "", pwd: pwd ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardEvents()
    }
    func login(email: String, pwd: String) {
        NetworkManager.sharedInstance.login(email: email, pwd: pwd) { [weak self] (res) in
            guard let `self` = self else {
                return
            }
            switch res {
            case .success(let authorization):
                guard let token = authorization.token, let expiresIn = authorization.expiresIn else {
                    return
                }
                UserData.setAuthorization(info: (token, expiresIn, Date()))
                self.dismiss(animated: true, completion: nil)
            case .failure(let type):
                print("fail")
                self.failureAlert(type: type)
            }
        }
    }
}
