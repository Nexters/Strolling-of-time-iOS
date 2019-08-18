//
//  InitialViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    // MARK: - Interface
    @IBOutlet private weak var joinButton: UIButton?
    // MARK: - Private
    private func setButtonAttr() {
        let skipLoginButtonAttr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15),
                                                                  .foregroundColor: UIColor.black,
                                                                  .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "가입하기",
                                                        attributes: skipLoginButtonAttr)
        self.joinButton?.setAttributedTitle(attributeString, for: .normal)
    }
    // MARK: - Action
    @IBAction private func login(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: LoginViewController.self, isPresentModally: false)
    }
    @IBAction private func join(_ sender: Any) {
        self.moveTo(storyboard: .main, viewController: JoinViewController.self, isPresentModally: true)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonAttr()
    }
}
