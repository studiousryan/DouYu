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
    private lazy var pageTitleView: PageTitleVIew = {
        let viewTitles = ["推荐", "游戏", "娱乐", "趣玩"]
        let viewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTitleViewHeight)
        let pageTitleView = PageTitleVIew(frame: viewFrame, titles: viewTitles)
        
        return pageTitleView
    }()
    
    
    
    private lazy var pageContentView: PageContentView = {
        // 设置frame
        let viewHeight = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTitleViewHeight
        let viewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: viewHeight)

        // 创建子控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let VC = UIViewController()
            VC.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(VC)
        }
        
        let pageContentView = PageContentView(frame: viewFrame, childVCs: childVCs, parentVC: self)
        
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
//        pageContentView.backgroundColor = UIColor.orange
        
        // 设置pageContentView位置
        setPageContentViewPosition(pageContentView: pageContentView)
    }
    
//    private func setPageTitleView() {
//        let titleFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kTitleViewHeight)
//        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
//        
//        let pageTitleView = PageTitleVIew(frame: titleFrame, titles: titles)
//        view.addSubview(pageTitleView)
//        
//        // 设置pageTitleView位置
//        setPageTitleViewPosition(pageTitleView: pageTitleView)
//    }
    
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
        pageContentView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor).isActive = true
        pageContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
