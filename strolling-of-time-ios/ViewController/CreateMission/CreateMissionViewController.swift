//
//  CreateMissionViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class CreateMissionViewController: UIViewController, NibLoadable {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var createMission: UIButton!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    private var startDate: Date?
    private var endDate: Date?
    private var goalTime = 1
    lazy var datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        let loc = Locale(identifier: "ko_KR")
        datePicker.locale = loc
        datePicker.datePickerMode = .dateAndTime
        return datePicker
    }()
    lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd hh:mm"
        return formatter
    }()
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    private let pickerViewData = Array(1...10)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        hideKeyboarOnTap()
        setTextField()
    }
    func setNavigationBar() {
        self.navigationBar.barTintColor = .white
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
    }
    func setTextField() {
        self.setPicker(startTextField)
        self.setPicker(endTextField)
        self.setPicker(goalTextField)
        self.startTextField.delegate = self
        self.endTextField.delegate = self
        self.titleTextField.delegate = self
        self.goalTextField.delegate = self
    }
    func isCreateButtonValid() -> Bool {
        guard startDate != nil && endDate != nil && titleTextField.text != "" else {
            return false
        }
        return true
    }
    func setCreateMissionButton() {
        self.createMission.setValidButton(isActive: isCreateButtonValid())
    }
    @IBAction func createMission(_ sender: Any) {
        guard let startDate = self.startDate, let endDate = self.endDate, let missionTitle = self.titleTextField.text else {
            return
        }
        print(startDate.toStringKST(dateFormat: "yyyy.MM.dd hh:mm"))
        print(endDate.toStringKST(dateFormat: "yyyy.MM.dd hh:mm"))
        print(missionTitle)
        self.dismiss(true)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//DatePicker
extension CreateMissionViewController {
    func setPicker(_ textField: UITextField){
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        if textField == self.startTextField || textField == self.endTextField {
            textField.inputView = self.datePicker
        } else {
            textField.inputView = self.pickerView
        }
    }
    @objc func donedatePicker(){
        self.view.endEditing(true)
    }
}
//UITextField
extension CreateMissionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.startTextField, self.endTextField:
            guard let datePicker = textField.inputView as? UIDatePicker else {
                return
            }
            if textField == startTextField {
                self.startDate = datePicker.date
            } else {
                self.endDate = datePicker.date
            }
            textField.text = self.dateFormatter.string(from: datePicker.date)
        default:
            break
        }
        self.setCreateMissionButton()
    }
}

//UIPicker
extension CreateMissionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row].description
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.goalTime = pickerViewData[row]
        self.goalTextField.text = "\(pickerViewData[row]) 시간"
    }
}
