//
//  CreateGroupViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/07.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView?
    var sampleMember = ["sujin", "naljin"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    func setupCollectionView(){
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMember.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: CreateGroupMemberCollectionViewCell.self, for: indexPath)
        if indexPath.row != sampleMember.count {
            cell.configure(data: "member")
        } else {
            cell.configure(data: "add")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != sampleMember.count {
            print("select")
        } else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let addMemeberViewController = mainStoryboard.viewController(AddMemeberViewController.self)
            self.show(addMemeberViewController, sender: nil)
        }
    }
}
