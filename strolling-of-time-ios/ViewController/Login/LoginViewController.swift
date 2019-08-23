//
//  LoginViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NibLoadable, AlertUsable {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    private var mainStoryboard: UIStoryboard? {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    @IBAction private func join(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: JoinViewController.self, isPresentModally: true)
    }
    @IBAction func login(_ sender: Any) {
        guard let mainVC = mainStoryboard?.instantiateViewController(withIdentifier: "MainNavi") else {
            return
        }
        self.present(mainVC, animated: true, completion: nil)
//        let email = emailTextField.text
//        let pwd = pwdTextField.text
//        self.login(email: email ?? "", pwd: pwd ?? "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboarOnTap()
        setTextField()
        self.loginButton.makeRounded()
    }
    func setTextField() {
        self.emailTextField.delegate = self
        self.pwdTextField.delegate = self
    }
    func isLoginButtonValid() -> Bool {
        guard emailTextField.text != "" && pwdTextField.text != "" else {
            return false
        }
        return true
    }
    func setLoginButton() {
        self.loginButton.setValidButton(isActive: isLoginButtonValid())
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.setLoginButton()
    }
}

//통신
extension LoginViewController {
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
