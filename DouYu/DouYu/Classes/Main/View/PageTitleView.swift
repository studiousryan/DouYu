//
//  PageTitleView.swift
//  DouYu
//
//  Created by Ryan on 2019/8/15.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

private let kScrollLineHeight: CGFloat = 2

class PageTitleVIew: UIView {
    var titleLabels: [UILabel] = []
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        
        // 设置UI
        setupUI(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleVIew {
    private func setupUI(titles: [String]) {
        // 添加titles对应的labels
        setupTitleLabels(titles: titles)
        
        // 添加scrollView
        setupScrollView()
        
        // 设置底线
        setupBottomLine()
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.frame = bounds
        
        addSubview(scrollView)
        
        // 设置底部滚动滑块
        setupScrollLine(scrollView: scrollView)
    }
    
    private func setupTitleLabels(titles: [String]) {
        let labelWidth: CGFloat = frame.width / CGFloat(titles.count)
        let labelHeight: CGFloat = frame.height - kScrollLineHeight
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            // 设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 设置label frame
            let labelX: CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            // 添加Label
            addSubview(label)
            
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLine() {
        // 添加底线
        let bottomLineView = UIView()
        let bottomLineViewHeight: CGFloat = 0.5
        bottomLineView.backgroundColor = UIColor.lightGray
        bottomLineView.frame = CGRect(x: 0, y: frame.height - bottomLineViewHeight, width: frame.width, height: bottomLineViewHeight)
        addSubview(bottomLineView)
    }
    
    private func setupScrollLine(scrollView: UIScrollView) {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        // 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        
        // 设置scrollLine属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineHeight, width: firstLabel.frame.width, height: kScrollLineHeight)
        
        // 添加scrollLine
        scrollView.addSubview(scrollLine)
    }
}
