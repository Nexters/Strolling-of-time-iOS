//
//  MainViewController.swift
//  strolling-of-time-ios
//
//  Created by 강수진 on 2019/08/08.
//  Copyright © 2019 wiw. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var sampleGroup = ["sujin", "naljin"]
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationbar()
        setupCollectionView()
        setupPageControl()
    }
    
    func setupNavigationbar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = .clear
    }
    func setupCollectionView(){
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    func setupPageControl() {
        let angle = CGFloat.pi/2
        self.pageControl?.transform = CGAffineTransform(rotationAngle: angle)
        pageControl?.currentPageIndicatorTintColor = .white
        pageControl?.pageIndicatorTintColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        pageControl?.numberOfPages = sampleGroup.count
        pageControl?.currentPage = 0
    }
    
    @IBAction func createGroup(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupNavi = mainStoryboard.instantiateViewController(withIdentifier: "createGroupNavi")
        self.present(createGroupNavi, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: MainCollectionViewCell.self, for: indexPath)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height-self.view.safeAreaInsets.top-self.view.safeAreaInsets.bottom)
    }
}

extension MainViewController {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let collectionView = self.collectionView else {
            return
        }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        self.pageControl?.currentPage = visibleIndexPath?.row ?? 0
    }
}
