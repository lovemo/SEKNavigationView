//
//  SegmentBaseViewController.swift
//  NavigationViewDemo
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class SegmentBaseViewController: UIViewController {

    /// 底部的所有内容
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.frame = self.view.bounds
        contentView.y = 64
        contentView.delegate = self
        contentView.pagingEnabled = true
        self.view.insertSubview(contentView, atIndex:0)
        contentView.contentSize = CGSizeMake(contentView.width * CGFloat(self.childViewControllers.count), 0)
        return contentView
    }()
    
    let topNavView = SEKNavigationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
extension SegmentBaseViewController: SEKNavigationViewDelegate {
    
    func navButtonClick(button: UIButton) {
        // 滚动
        var offset = self.contentView.contentOffset
        offset.x = CGFloat(button.tag) * self.contentView.width
        contentView.setContentOffset(offset, animated: true)
    }
    
    func navLeftButtonClick(button: UIButton) {
        navigationController?.popViewControllerAnimated(true)
        print("左")
    }
    
    func navRightButtonClick(button: UIButton) {
        print("右")
    }
}

extension SegmentBaseViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        // 当前的索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        
        // 取出子控制器
        let vc = self.childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        // 点击按钮
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        topNavView.titleClick(topNavView.titlesView.subviews[index] as! UIButton)
    }
}
