//
//  AddGroupMemberViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/20.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class AddGroupMemberViewController: UIViewController, NibLoadable {
    
    typealias SelectedMember = (member: String, image: String, index: Int)
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var invitationButton: UIButton!
    var delegate: SendDataDelegate?
    private var searchTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "닉네임 또는 메일로 검색해보세요"
        txtField.font = UIFont.systemFont(ofSize: 18.0)
        return txtField
    }()
    var tableViewSampleMember: [SelectedMember] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var collectionViewSampleMember: [SelectedMember] = []
    var sampleMember :[SelectedMember] = [("최고운", "background", 1), ("김민철", "background", 2), ("진성곤", "background", 3), ("박다예", "background", 4), ("강수진", "background", 5), ("조우현", "background", 6)]
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            delegate?.sendData(data: self.collectionViewSampleMember)
        }
    }
    func collectionViewDataDidChanged() {
        collectionViewHeight.constant = collectionViewSampleMember.isEmpty ? 0 : 150
        self.invitationButton.setValidButton(isActive: !collectionViewSampleMember.isEmpty)
        let buttonTitle = collectionViewSampleMember.isEmpty ? "멤버를 초대해주세요" : "\(collectionViewSampleMember.count)명에게 초대장 보내기"
        self.invitationButton.setTitle(buttonTitle, for: .normal)
        self.collectionView?.reloadData()
    }
    override func viewDidLayoutSubviews() {
       collectionViewDataDidChanged()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar()
        setupCollectionView()
        setupTableView()
        setupTextfield()
        setupInvitationButton()
        hideKeyboarOnTap_()
    }
    func setNavigationbar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = searchTxtField
    }
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewHeight.constant = 0
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
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
        self.navigationController?.popViewController(animated: true)
    }
}

//TableView
extension AddGroupMemberViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSampleMember.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: AddGroupMemberTableViewCell.self)
        cell.configure(data: tableViewSampleMember[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard collectionViewSampleMember.count < 10 else {
            self.simpleAlert(title: "오류", message: "10명 이상을 추가할 수 없습니다")
            return
        }
        let selectedMemeber = tableViewSampleMember[indexPath.row]
        if !collectionViewSampleMember.map({(_, _, idx) -> Int in
            return idx
        }).contains(selectedMemeber.index) {
            self.collectionViewSampleMember.append(selectedMemeber)
            self.collectionViewDataDidChanged()
        }
    }
}

//CollectionView
extension AddGroupMemberViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewSampleMember.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: AddGroupMemberCollectionViewCell.self, for: indexPath)
        cell.configure(row: indexPath.row, data: collectionViewSampleMember[indexPath.row])
        cell.setCallback {[weak self] (row: Int) in
            guard let `self` = self else {
                return
            }
            self.collectionViewSampleMember.remove(at: indexPath.row)
            self.collectionViewDataDidChanged()
        }
        return cell
    }
}

//textField
extension AddGroupMemberViewController: UITextFieldDelegate, AlertUsable {
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
            let (member, _, _) = arg
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
            print("enter")
        }
        return true
    }
}

//키보드
extension AddGroupMemberViewController {
    private func hideKeyboarOnTap_() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboardAction(view: UIView) {
        self.searchTxtField.endEditing(true)
    }
}
