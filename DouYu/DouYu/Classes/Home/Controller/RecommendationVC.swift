//
//  RecommendationVC.swift
//  DouYu
//
//  Created by Ryan on 2019/8/19.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemWidth: CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemHeight: CGFloat = kItemWidth * 3 / 4
private let kSectionNumber: Int = 12
private let kSectionHeaderHeight: CGFloat = 80

private let kNormalCellID: String = "kNormalCellID"
private let kHeaderViewID: String = "kHeaderViewID"

class RecommendationVC: UIViewController {
    private lazy var collectionView: UICollectionView = { [unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
//        layout.itemSize = CGSize(width: kItemWidth, height: 40)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kSectionHeaderHeight)
//        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 80)
        
        // 创建UICollectionVIew
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.orange
        
        // 注册cell和header
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader.self, withReuseIdentifier: kHeaderViewID)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
//        print("collectionView: \(collectionView.frame.origin.y)")
//        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        setupUI()
    }
}

// 设置UI
extension RecommendationVC {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}

extension RecommendationVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kSectionNumber
//        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
        
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        header.backgroundColor = UIColor.red
        return header
    }
}
