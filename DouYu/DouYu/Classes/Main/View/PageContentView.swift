//
//  PageContentView.swift
//  DouYu
//
//  Created by Ryan on 2019/8/16.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(pageContentView: PageContentView, beginningIndex: Int, targetIndex: Int, progress: CGFloat)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    private var beginningOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        // 配置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // 配置数据来源
        collectionView.dataSource = self
        
        // 遵守协议
        collectionView.delegate = self
        
        // 注册UICollectionViewCell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
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
            parentVC?.addChild(childVC)
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

// MARK:- 遵守UICollectionViewDelegate协议
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginningOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 定义所需数据
        var progress: CGFloat = 0
        var beginningIndex: Int = 0
        var targetIndex: Int = 0
        
        // 判断滑动方向和比例
        let currentOffsetX = scrollView.contentOffset.x
        let offsetDiff = currentOffsetX - beginningOffsetX
        let offsetDiffAbsolute = abs(offsetDiff)
        let scrollViewScreenWidth = scrollView.bounds.width
        
        progress = offsetDiffAbsolute / scrollViewScreenWidth
        
        // 左滑
        if offsetDiff > 0 {
            beginningIndex = Int(currentOffsetX / scrollViewScreenWidth)
            
            
            
            targetIndex = beginningIndex + 1
            
            // 防止越界
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            // 一次滑过一个view
            if offsetDiffAbsolute == scrollViewScreenWidth {
                targetIndex = beginningIndex
            }
        }
        // 右滑
        else if offsetDiff < 0 {
            targetIndex = Int(currentOffsetX / scrollViewScreenWidth)
            
            beginningIndex = targetIndex + 1
            
            // 防止越界
            if beginningIndex >= childVCs.count {
                beginningIndex = childVCs.count - 1
            }
            
            // 一次滑过一个view
            if offsetDiffAbsolute == scrollViewScreenWidth {
                beginningIndex = beginningIndex - 1
            }
        }
        else {
            beginningIndex = Int(currentOffsetX / scrollViewScreenWidth)
            targetIndex = beginningIndex
        }
        
//        print("currentOffsetX: \(currentOffsetX) | scrollViewScreenWidth: \(scrollViewScreenWidth) | beginningIndex: \(beginningIndex) | targetIndex: \(targetIndex)")
        
        progress = offsetDiffAbsolute / scrollViewScreenWidth
        
        // 将beginning, targetIndex, progress 传给 PageTitleView
        delegate?.pageContentView(pageContentView: self, beginningIndex: beginningIndex, targetIndex: targetIndex, progress: progress)
    }
}

// MARK:- 对外暴露方法
extension PageContentView {
    func updateCurrentLabelIndex(index: Int) {        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}


