//
//  UIColor-Extention.swift
//  DouYu
//
//  Created by Ryan on 2019/8/16.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat){
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
