//
//  JoinViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/17.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController, NibLoadable, KeyboardObserving {

    // MARK: - Private
    @IBOutlet private weak var profileImageView: UIImageView?
    @IBOutlet private weak var idTextField: UITextField?
    @IBOutlet private weak var pwdTextField: UITextField?
    @IBOutlet private weak var nicknameTextField: UITextField?
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        return picker
    }()
    private func setUI() {
        self.profileImageView?.contentMode = .scaleAspectFill
        self.profileImageView?.makeRounded()
    }
    // MARK: - Action
    @IBAction private func selectImage(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        present(picker, animated: true)
    }
    @IBAction private func join(_ sender: Any) {
        let id = idTextField?.text
        let pwd = pwdTextField?.text
        let nickname = nicknameTextField?.text
        print("통신 \(id) \(pwd) \(nickname)")
    }
    override func viewDidLayoutSubviews() {
        self.setUI()
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardEvents()
    }
}
// MARK: - ImagePickerController & NavigationController
extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.profileImageView?.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}
