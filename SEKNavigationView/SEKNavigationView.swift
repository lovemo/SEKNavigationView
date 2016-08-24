//
//  SEKNavigationView.swift
//  NavigationViewDemo
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

/// 导航栏代理
@objc protocol SEKNavigationViewDelegate{
    /// 导航栏按钮点击
    func navButtonClick(button: UIButton)
    /// 导航栏按钮点击
    optional func navLeftButtonClick(button: UIButton)
    /// 导航栏按钮点击
    optional func navRightButtonClick(button: UIButton)
}

class SEKNavigationView: UIView {
    
    /// 内部按钮点击代理
    weak var delegate: SEKNavigationViewDelegate?
    
    /// 当前选中的按钮
    lazy var selectedButton = UIButton()
    
    /// 是否铺满
    var isFillout = false
    
    /// 是否默认选中中间按钮
    var isSelectedMiddleButton = false
    
    /// 标题视图的宽度
    var titlesViewW: CGFloat = 0.0 {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    /// 标题视图中按钮的间隔距离
    var titlesViewMargin: CGFloat = 6.0 {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    /// 指示器与按钮的间隔距离
    var indicatorViewMargin: CGFloat = 5.0 {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    /// 标题按钮的正常颜色，即非选中颜色，建议在设置标题数组前设置此属性
    var titleButtonNormalColor:UIColor = UIColor.grayColor()
    
    /// 标题按钮的禁用颜色，即选中颜色，防止用户多次点击，建议在设置标题数组前设置此属性
    var titleButtonDisabledColor:UIColor = UIColor.redColor()
    
    /// 标题按钮的文字大小，建议在设置标题数组前设置此属性
    var titleButtonTitleFont: UIFont = UIFont.systemFontOfSize(14)
    
    /// 顶部的所有标签
    lazy var titlesView: UIScrollView = {
        // 标签栏整体
        let titlesView = UIScrollView()
        titlesView.showsVerticalScrollIndicator = false
        titlesView.showsHorizontalScrollIndicator = false
        titlesView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        self.addSubview(titlesView)
        return titlesView
    }()
    
    /// 标签栏底部的红色指示器
    lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        // 底部的红色指示器
        indicatorView.backgroundColor = UIColor.redColor()
        indicatorView.tag = -1
        return indicatorView
    }()
    
    /// 左边按钮，默认隐藏
    lazy var leftButton: UIButton? =  {
        let leftButton = UIButton()
        leftButton.hidden = true
        leftButton.addTarget(self, action: #selector(SEKNavigationView.leftButtonClick(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(leftButton)
        return leftButton
    }()
    
    /// 右边按钮，默认隐藏
    lazy var rightButton: UIButton? = {
        let rightButton = UIButton()
        rightButton.hidden = true
        rightButton.addTarget(self, action: #selector(SEKNavigationView.rightButtonClick(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(rightButton)
        return rightButton
    }()
    
    /// 标题数组
    var titles: [String]? {
        didSet {
            if titles?.count <= 0 {return}
            for i in 0..<titles!.count {
                let button = UIButton()
                button.tag = i
                button.setTitle(titles![i], forState: .Normal)
                button.setTitleColor(titleButtonNormalColor, forState: .Normal)
                button.setTitleColor(titleButtonDisabledColor, forState: .Disabled)
                button.titleLabel?.font = titleButtonTitleFont
                button.addTarget(self, action: #selector(SEKNavigationView.titleClick(_:)), forControlEvents: .TouchUpInside)
                titlesView.addSubview(button)
                
                // 默认点击了哪个个按钮
                if i == (self.isSelectedMiddleButton ? ((titles!.count - 1) / 2) : 0) {
                    button.enabled = false
                    selectedButton = button
                }
                
            }
            titlesView.addSubview(indicatorView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleClick(button: UIButton)
    {
        // 修改按钮状态
        selectedButton.enabled = true
        button.enabled = false
        selectedButton = button
        
        // 动画
        UIView.animateWithDuration(0.25) {
            self.indicatorView.width = self.isFillout ? self.titlesViewW / CGFloat(self.titles!.count) : button.titleLabel!.width
            self.indicatorView.centerX = button.centerX;
        }
        
        delegate?.navButtonClick(button)
    }
    
    func leftButtonClick( button: UIButton) {
        delegate?.navLeftButtonClick!(button)
    }
    
    func rightButtonClick( button: UIButton) {
        delegate?.navRightButtonClick!(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonItemX: CGFloat = 14.0
        let buttonItemW: CGFloat = 28
        // 布局左边按钮
        leftButton?.x = buttonItemX
        leftButton?.y = (self.height - buttonItemW) * 0.5
        leftButton?.width = buttonItemW
        leftButton?.height = buttonItemW

        // 布局右边按钮
        rightButton?.x = self.width - buttonItemX - buttonItemW
        rightButton?.y = (self.height - buttonItemW) * 0.5
        rightButton?.width = buttonItemW
        rightButton?.height = buttonItemW
       
        // 布局titlesView
        if titles?.count <= 0 || titlesView.subviews.count <= 0 {return}
        self.titlesView.frame = self.bounds
        self.titlesView.width = titlesViewW
        self.titlesView.centerX = self.centerX
        indicatorView.height = 3
        indicatorView.y = titlesView.height - indicatorView.height
   
        let height = titlesView.height
        var lastBtn = UIButton()
        lastBtn.frame = CGRectZero
        
        for i in 0..<titles!.count {
            if !titlesView.subviews[i].isKindOfClass(UIButton.classForCoder()) {
                continue
            }
            let button = titlesView.subviews[i] as! UIButton
            button.tag = i
            button.height = height
            button.sizeToFit()
            button.x = CGRectGetMaxX(lastBtn.frame) + titlesViewMargin
            lastBtn = button
            
            // 布局指示器的位置
            self.indicatorView.y = CGRectGetMaxY(button.frame) + indicatorViewMargin
            
            if i == (self.isSelectedMiddleButton ? ((titles!.count - 1) / 2) : 0) {
                // 让按钮内部的label根据文字内容来计算尺寸
                button.titleLabel!.sizeToFit()
                self.indicatorView.width = self.isFillout ? self.titlesViewW / CGFloat(self.titles!.count) : button.titleLabel!.width
                self.indicatorView.centerX = button.centerX
            }
            if i == titles!.count - 1 {
                // 设置titlesView的contentSize
                titlesView.contentSize = CGSize(width: CGRectGetMaxX(button.frame), height: titlesView.height)
            }
        }
        
    }
}
