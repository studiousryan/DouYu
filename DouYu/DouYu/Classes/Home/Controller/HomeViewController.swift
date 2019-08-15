//
//  HomeViewController.swift
//  DouYu
//
//  Created by Ryan on 2019/8/15.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    private func setupUI() {
        // 设置导航栏
        setNavigationBar()
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
}
