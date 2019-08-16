//
//  PageContentView.swift
//  DouYu
//
//  Created by Ryan on 2019/8/16.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    private var childVCs: [UIViewController]
    private var parentVC: UIViewController
    
    private lazy var collectionView: UICollectionView = {
        // 配置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // 配置数据来源
        collectionView.dataSource = self
        
        // 注册UICollectionViewCell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI() {
        // 将所有子控制器添加到父控制器
        for childVC in childVCs {
            parentVC.addChild(childVC)
        }
        
        // 添加UICollectionView
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 配置cell
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}
