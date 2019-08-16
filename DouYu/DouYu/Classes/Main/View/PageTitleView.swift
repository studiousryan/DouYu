//
//  PageTitleView.swift
//  DouYu
//
//  Created by Ryan on 2019/8/15.
//  Copyright © 2019 Daoxiang Deng. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex: Int)
}

private let kScrollLineHeight: CGFloat = 2

class PageTitleView: UIView {
    private var currentLableIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    // titleLabels
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    // scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.frame = bounds
        
        return scrollView
    }()
    
    // scrollLine
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    // 初始化
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        
        // 设置UI
        setupUI(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension PageTitleView {
    private func setupUI(titles: [String]) {
        // 添加scrollView
        addSubview(scrollView)
        
        // 添加titles对应的labels
        setupTitleLabels(titles: titles)
        
        // 设置底线
        setupBottomLine()
        
        // 添加scrollLine
        scrollView.addSubview(scrollLine)
        
        // 设置scrollLine
        setupScrollLine()
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
            
            // 给label添加手势控制
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tilteLabelTapped))
            label.addGestureRecognizer(tapGesture)
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
    
    private func setupScrollLine() {
        // 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor.orange
        
        // 设置scrollLine属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineHeight, width: firstLabel.frame.width, height: kScrollLineHeight)
    }
}

// MARK:- 监听点击
extension PageTitleView {
    @objc private func tilteLabelTapped(tapGesture: UITapGestureRecognizer) {
        // 获取当前label
        guard let currentLabel = tapGesture.view as? UILabel else { return }
        
        // 获取之前label
        let previousLabel = titleLabels[currentLableIndex]
        
        // 调整label颜色
        previousLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.orange
        
        // 更新当前label下标
        currentLableIndex = currentLabel.tag
        
        // 更新scorllLine位置
        let scrollLineX = CGFloat(currentLableIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 通知代理
        delegate?.pageTitleView(pageTitleView: self, selectedIndex: currentLableIndex)
    }
}

// MARK:- 对外暴露方法
extension PageTitleView {
    func updateTitleView(beginningIndex: Int, targetIndex: Int, progress: CGFloat) {
        // 获取 beginningLabel 和 targetLabel
        let beginningLabel = titleLabels[beginningIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块逻辑
        let XAvailableDistance = targetLabel.frame.origin.x - beginningLabel.frame.origin.x
        let actualDistance = XAvailableDistance * progress
        scrollLine.frame.origin.x = beginningLabel.frame.origin.x + actualDistance
    }
}
