//
//  UIBarButtonItem-Extension.swift
//  DouYu
//
//  Created by Ryan on 2019/8/15.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    public convenience init(imageName: String, highlightedImageName: String = "", frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        
        // 创建button
        let btn = UIButton()
        
        // 设置button图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        }
        
        // 设置button尺寸
        if frame == CGRect(x: 0, y: 0, width: 0, height: 0) {
            btn.sizeToFit()
        } else {
            btn.frame = frame
        }
        
        // 创建UIBarButtonItem
        self.init(customView: btn)
    }
}
