//
//  AddMemeberViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class AddMemeberViewController: UIViewController, NibLoadable {
    
    typealias SelectedMember = (member: String, index: Int)
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet weak var invitationButton: UIButton!
    private var keyboardDismissGesture: UITapGestureRecognizer?
    private var searchTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "닉네임 또는 메일로 검색해보세요"
        txtField.font = UIFont.systemFont(ofSize: 14.0)
        return txtField
    }()
    private var tableViewSampleMember: [SelectedMember] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    private var collectionViewSampleMember: [SelectedMember] = [] {
        didSet {
            collectionViewHeight.constant = collectionViewSampleMember.isEmpty ? 0 : 150
            self.invitationButton.backgroundColor = collectionViewSampleMember.isEmpty ? .gray : .green
            self.invitationButton.setTitle("\(collectionViewSampleMember.count)명에게 초대장 보내기", for: .normal)
            self.collectionView?.reloadData()
        }
    }
    var sampleMember :[SelectedMember] = [("111", 53), ("222", 12)]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        setupTextfield()
        setKeyboardSetting()
        setupInvitationButton()
        navigationItem.titleView = searchTxtField
    }
    func setupCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionViewHeight.constant = 0
    }
    func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    func setupTextfield() {
        searchTxtField.delegate = self
        searchTxtField.addTarget(self, action: #selector(searchBarEditingChanged(_:)), for: .editingChanged)
    }
    func setupInvitationButton() {
        invitationButton.addTarget(self, action: #selector(inviteMember), for: .touchUpInside)
        self.invitationButton.backgroundColor = .gray
        self.invitationButton.setTitle("0명에게 초대장 보내기", for: .normal)
    }
    @objc func inviteMember() {
        self.dismiss(animated: true, completion: nil)
    }
}

//TableView
extension AddMemeberViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSampleMember.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: AddMemberTableViewCell.self)
        cell.configure(data: tableViewSampleMember[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard collectionViewSampleMember.count < 10 else {
            self.simpleAlert(title: "오류", message: "10명 이상을 추가할 수 없습니다")
            return
        }
        let selectedMemeber = tableViewSampleMember[indexPath.row]
        if !collectionViewSampleMember.map({(_, idx) -> Int in
            return idx
        }).contains(selectedMemeber.index) {
            self.collectionViewSampleMember.append(selectedMemeber)
        }
    }
}

//CollectionView
extension AddMemeberViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewSampleMember.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: AddMemberCollectionViewCell.self, for: indexPath)
        cell.configure(data: collectionViewSampleMember[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionViewSampleMember.remove(at: indexPath.row)
    }
}

//textField
extension AddMemeberViewController: UITextFieldDelegate, AlertUsable {
    @objc func searchBarEditingChanged(_ searchBar: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchMember(_:)), object: searchBar)
        perform(#selector(self.searchMember(_:)), with: searchBar, afterDelay: 0.5)
    }
    @objc func searchMember(_ searchBar: UISearchBar) {
        //실시간 통신?
        guard let searchText = searchBar.text else {
            return
        }
        self.tableViewSampleMember = self.sampleMember.filter { (arg) -> Bool in
                                                                let (member, _) = arg
                                                                return member.contains(searchText)
                                                                }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            simpleAlert(title: "오류", message: "검색어를 입력해주세요")
            return false
        }
        if let myString = textField.text {
            let emptySpacesCount = myString.components(separatedBy: " ").count-1
            if emptySpacesCount == myString.count {
                simpleAlert(title: "오류", message: "검색어를 입력하세요")
                return false
            }
        }
        if let searchString = textField.text {
            print("enter 누름")
        }
        return true
    }
}

//키보드 대응
extension AddMemeberViewController{
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        searchTxtField.text = ""
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
    }
    
    //화면 바깥 터치했을때 키보드 없어지는 코드
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.searchTxtField.endEditing(true)
    }
    
}
