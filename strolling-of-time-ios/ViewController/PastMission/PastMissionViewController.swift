//
//  PastMissionViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/19.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class PastMissionViewController: UIViewController, NibLoadable {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "지난 미션"
    }
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        registerCell()
    }
    func registerCell() {
        let missionCellNibName = UINib(nibName: "MissionCell", bundle: nil)
        tableView.register(missionCellNibName, forCellReuseIdentifier: MissionTableViewCell.nibId)
    }
}
extension PastMissionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(for: MissionTableViewCell.self)
        return cell
    }
}
