//
//  MainViewController.swift
//  Swift-图片轮播
//
//  Created by on 14-10-10.
//  Copyright (c) 2014年 . All rights reserved.
//

// 模拟器不能运行的话，请在iOS8的真机上运行

import UIKit

class MainViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var timer: NSTimer!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    // 添加图片
        var width:CGFloat = scrollView.frame.width
        var height:CGFloat = scrollView.frame.height
        
        for var i:CGFloat = 1 ; i < 6; ++i{
            var imageName:String = "img_0\(i)"
            
            var imageView = UIImageView()
            var x = (i - 1) * width
            imageView.image = UIImage(named: imageName)
            imageView.frame = CGRectMake(x, 0, width, height)
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSizeMake(5 * width, 0)        
        pageControl.numberOfPages = 5
        
        self.addScrollTimer()
    }
    
    // 添加时间计时器
    func addScrollTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target:self, selector:"nextPage", userInfo:nil, repeats:true)
    }
    
    // 移除时间计时器
    func removeScrollTimer(){
        
        timer.invalidate()
        timer = nil
    }
    
    // 下一页自动轮播
    func nextPage(){
       
        var currentPage:CGFloat = CGFloat(pageControl.currentPage)
        currentPage++
        if currentPage == 5 {
            currentPage = 0
        }
        let width:CGFloat = scrollView.frame.width
        var offset:CGPoint = CGPointMake(currentPage * width, 0)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.scrollView.contentOffset = offset
        })
    
    }
    
    // scrollView的代理方法
    // 结束滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offset:CGPoint = self.scrollView.contentOffset
        var offsetX:CGFloat = offset.x;
        let width:CGFloat = self.scrollView.frame.width
        self.pageControl.currentPage = (Int(offsetX + 0.5 * width) / Int(width))
    }

    // 开始拖拽
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeScrollTimer()
    }
    
    // 结束拖拽
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addScrollTimer()
    }
    
}

