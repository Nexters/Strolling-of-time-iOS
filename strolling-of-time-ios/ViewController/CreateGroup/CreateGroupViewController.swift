//
//  CreateGroupViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    typealias SelectedMember = (member: String, image: String, index: Int)
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var activeSwitch: UISwitch!
    @IBOutlet weak var maxCountTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createGroupButton: UIButton!
    private var type: GroupType?
    private var maxMember = 10
    private let maxMemberPickerViewData = Array(1...10)
    private var typePickerViewData: [GroupType] = []
    var sampleMembers: [SelectedMember] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        setTextField()
        hideKeyboarOnTap()
        makeTxtViewClear()
        typePickerViewData = GroupType.allCases
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    func setNavigationBar() {
        self.navigationBar.barTintColor = .white
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
    }
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func setTextField() {
        typeTextField.tag = 0
        maxCountTextField.tag = 1
        self.setPicker(typeTextField)
        self.setPicker(maxCountTextField)
        self.titleTextField.delegate = self
        self.typeTextField.delegate = self
        self.maxCountTextField.delegate = self
        self.descTextView.delegate = self
    }
    func makeTxtViewClear(){
        descTextView.text = "미션 설명을 작성해주세요 "
        descTextView.textColor = UIColor.lightGray
    }
    @IBAction func createGroup(_ sender: Any) {
        guard let type = self.type else {
            return
        }
        print(titleTextField.text)
        print(descTextView.text)
        print("\(type)")
        print(activeSwitch.isOn)
        print(maxMember)
        self.dismiss(true)
    }
    func isCreateButtonValid() -> Bool {
        guard type != nil && descTextView.text != "" && titleTextField.text != "" else {
            return false
        }
        return true
    }
    func setCreateMissionButton() {
        self.createGroupButton.setValidButton(isActive: isCreateButtonValid())
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMembers.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: CreateGroupCollectionViewCell.self, for: indexPath)
        if indexPath.row == sampleMembers.count {
            cell.profileImage.image = UIImage(named: "ovalBlack")
        } else {
            cell.profileImage.image = UIImage(named: sampleMembers[indexPath.row].image)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == sampleMembers.count {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let addMemeberViewController = mainStoryboard.viewController(AddGroupMemberViewController.self)
            addMemeberViewController.collectionViewSampleMember = self.sampleMembers
            addMemeberViewController.delegate = self
            self.show(addMemeberViewController, sender: nil)
        }
    }
}

//setpicker
extension CreateGroupViewController {
    func setPicker(_ textField: UITextField){
        var pickerView: UIPickerView = {
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            return picker
        }()
        pickerView.tag = textField.tag
        textField.inputView = pickerView
    }
}
//UITextField
extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.setCreateMissionButton()
    }
}

//UIPicker
extension CreateGroupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return typePickerViewData.count
        case 1:
            return maxMemberPickerViewData.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return typePickerViewData.map({ $0.rawValue })[row]
        case 1:
            return maxMemberPickerViewData[row].description
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            self.type = typePickerViewData[row]
            self.typeTextField.text = typePickerViewData.map({ $0.rawValue })[row]
        case 1:
            self.maxMember = maxMemberPickerViewData[row]
            self.maxCountTextField.text = maxMemberPickerViewData[row].description
        default:
            break
        }
    }
}
extension CreateGroupViewController: UITextViewDelegate {
    //텍스트뷰 플레이스 홀더처럼
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            makeTxtViewClear()
        }
    }
}

extension CreateGroupViewController: SendDataDelegate {
    func sendData<T>(data: T) {
        guard let data = data as? [SelectedMember] else {
            return
        }
        self.sampleMembers = data
    }
}
