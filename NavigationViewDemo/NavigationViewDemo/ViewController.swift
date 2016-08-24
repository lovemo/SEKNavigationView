//
//  ViewController.swift
//  NavigationViewDemo
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ViewController: SegmentBaseViewController {
    
    let titles = ["网页", "新闻", "贴吧", "知道", "音乐", "图片", "视频", "地图", "文库", "网盘", "更多"]
    var isShowNavgationViewButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 设置导航试图
        setupNavView()
        // 初始化子控制器
        setupChildVces()
        // 底部的scrollView
        setupContentView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    /// 设置导航视图
    private func setupNavView() {
        navigationController?.navigationBar.hidden = true
        topNavView.frame = CGRectMake(0, 20, self.view.width, 44)
        topNavView.backgroundColor = UIColor.whiteColor()
        topNavView.delegate = self
        topNavView.titleButtonNormalColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        topNavView.titleButtonDisabledColor = UIColor.redColor()
        topNavView.titleButtonTitleFont = UIFont.systemFontOfSize(16)
        topNavView.titles = titles
        topNavView.titlesViewW = topNavView.width
        if isShowNavgationViewButton {
            topNavView.titlesViewW = topNavView.width - 100
            topNavView.leftButton?.hidden = false
            topNavView.rightButton?.hidden = false
            topNavView.leftButton?.setImage(UIImage(named: "icon_menu"), forState: .Normal)
            topNavView.rightButton?.setImage(UIImage(named: "icon_videocam"), forState: .Normal)
        }
        view.addSubview(topNavView)
    }
    
    /// 初始化子控制器
    private func setupChildVces()
    {
        for _ in 0..<titles.count {
            let voice = UIViewController()
            addChildViewController(voice)
            voice.view.backgroundColor = randomColor()
        }
        
    }
    /// 底部的scrollView
    private func setupContentView()
    {
        // 不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        // 添加第一个控制器的view
        self.scrollViewDidEndScrollingAnimation(contentView)
    }

    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        let alpha = CGFloat(1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
    }
    
}


