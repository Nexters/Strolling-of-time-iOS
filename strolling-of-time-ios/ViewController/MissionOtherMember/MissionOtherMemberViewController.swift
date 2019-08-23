//
//  MissionOtherMemberViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/23.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MissionOtherMemberViewController: UIViewController, NibLoadable {

    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissBackView: UIView!
    var sampleMembers = ["sujin", "naljin", "sujin", "naljin", "sujin", "naljin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setCollectionView()
    }
    override func viewDidLayoutSubviews() {
        dismissBackView.makeRoundedSelectedCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension MissionOtherMemberViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: MissionOtherMemberTableViewCell.self)
        return cell
    }
}

extension MissionOtherMemberViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMembers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell2", for: indexPath) as? GroupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(data: self.sampleMembers[indexPath.row])
        return cell
    }
}
