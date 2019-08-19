//
//  HomeViewController.swift
//  DouYu
//
//  Created by Ryan on 2019/8/15.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let viewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleViewHeight)
        let viewTitles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: viewFrame, titles: viewTitles)
        
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        // 设置frame
        let viewHeight = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTitleViewHeight
        let viewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: viewHeight)

        // 创建子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendationVC())
        
        for index in 0..<3 {
            let VC = UIViewController()
            
//            VC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            if index == 0 {
                VC.view.backgroundColor = UIColor.red
            } else if index == 1 {
                VC.view.backgroundColor = UIColor.green
            } else if index == 2 {
                VC.view.backgroundColor = UIColor.blue
            } else if index == 3 {
                VC.view.backgroundColor = UIColor.darkGray
            }
            
            childVCs.append(VC)
        }
        
        for VC in childVCs {
            VC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
        let pageContentView = PageContentView(frame: viewFrame, childVCs: childVCs, parentVC: self)
        pageContentView.delegate = self
        
        
        
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置整体界面
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    private func setupUI() {
        // 设置导航栏
        setNavigationBar()
        
        // 添加pageTitleView
        view.addSubview(pageTitleView)
        
        // 设置pageTitleView位置
        setPageTitleViewPosition(pageTitleView: pageTitleView)
        
        // 添加pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
        // 设置pageContentView位置
        setPageContentViewPosition(pageContentView: pageContentView)
        
        // 设置pageContentView下面collectionView位置
//        setPageContentViewCollectionViewPosition()
        
        // 调整pageContentView子控制器frame
//        setSubviewFrames(view: pageContentView)
    }
    
    private func setNavigationBar() {
        
        // 设置左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 设置右侧按钮尺寸
        let frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
        
        // 设置右侧按钮属性
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click", frame: frame)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_clicked", frame: frame)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click", frame: frame)
        
        // 添加右侧按钮
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
    private func setPageTitleViewPosition(pageTitleView: UIView) {
        pageTitleView.translatesAutoresizingMaskIntoConstraints = false
        pageTitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageTitleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageTitleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageTitleView.heightAnchor.constraint(equalToConstant: kTitleViewHeight).isActive = true
    }
    
    private func setPageContentViewPosition(pageContentView: UIView) {
        pageContentView.translatesAutoresizingMaskIntoConstraints = false
        pageContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: kTitleViewHeight).isActive = true
        pageContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setPageContentViewCollectionViewPosition() {
        pageContentView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageContentView.collectionView.topAnchor.constraint(equalTo: pageContentView.topAnchor).isActive = true
        pageContentView.collectionView.leftAnchor.constraint(equalTo: pageContentView.leftAnchor).isActive = true
        pageContentView.collectionView.rightAnchor.constraint(equalTo: pageContentView.rightAnchor).isActive = true
        pageContentView.collectionView.bottomAnchor.constraint(equalTo: pageContentView.bottomAnchor).isActive = true
    }
    
    
    
    private func setSubviewFrames(view: UIView) {
        let subviews = view.subviews
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            subview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            subview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}


// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex: Int) {
        pageContentView.updateCurrentLabelIndex(index: selectedIndex)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, beginningIndex: Int, targetIndex: Int, progress: CGFloat) {
        pageTitleView.updateTitleView(beginningIndex: beginningIndex, targetIndex: targetIndex, progress: progress)
    }
}
