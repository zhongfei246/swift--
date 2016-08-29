//
//  PageScrollView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class PageScrollView: UIView {

    private let imageViewMaxCount = 3
    private var imageScrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var timer: NSTimer?
    private var placeHolderImage: UIImage?
    private var imageClick:((index: Int) -> ())?
    var headData: HeadResources? {
    
        didSet {
        
            if timer != nil {
            
                timer!.invalidate()
                timer = nil
            }
            if headData?.data?.focus?.count >= 0 {
            
                pageControl.numberOfPages = (headData?.data?.focus?.count)!
                pageControl.currentPage = 0
                updatePageScrollView()
                
                startTimer()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建imageView
        buildImageScrollView()
        //添加页控制
        buildPageControl()
    }
    
    convenience init(frame: CGRect, placeholder: UIImage, focusImageViewClick: ((index: Int) -> Void)) {
        self.init(frame: frame)
        placeHolderImage = placeholder
        imageClick = focusImageViewClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageScrollView.frame = bounds
        imageScrollView.contentSize = CGSizeMake(CGFloat(imageViewMaxCount) * width, 0)
        /**
        *  for遍历
        */
        for i in 0...imageViewMaxCount - 1 {
        
            let imageView = imageScrollView.subviews[i] as! UIImageView
            imageView.userInteractionEnabled = true
            imageView.frame = CGRectMake(CGFloat(i) * imageScrollView.width, 0, imageScrollView.width, imageScrollView.height)
        }
        
        let pageW: CGFloat = 80
        let pageH: CGFloat = 20
        let pageX: CGFloat = imageScrollView.width - pageW
        let pageY: CGFloat = imageScrollView.height - pageH
        pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH)
        
        //更新scrollView
        updatePageScrollView()
    }
    
    //创建子控件的函数
    func buildImageScrollView() {
    
        imageScrollView = UIScrollView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.pagingEnabled = true
        imageScrollView.delegate = self
        addSubview(imageScrollView)
        
        for _ in 0..<3 {
        
            let imageView = UIImageView()
            let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
            imageView.addGestureRecognizer(tap)
            imageScrollView.addSubview(imageView)
        }
    }
    
    //pageControll
    func buildPageControl() {
    
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_normal")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_selected")!)
        addSubview(pageControl)
    }
    
//    MARK: 更新内容  这个轮播只有三张图片（ImageView），永远更新的时候偏移到中间的这张
    private func updatePageScrollView() {
    
        for var i=0; i < imageScrollView.subviews.count; i++ {
        let imageView = imageScrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            
            if i == 0 {  //如果遍历到第一个ImageView，index就是用当前获得的index-1，方便后续的设置tag和取图片（永远更新的时候偏移到中间的那张，所以要减1，index为上张的index）
            
                index--
                
            } else if 2 == i {  //如果遍历到第三个ImageView，index就是用当前获得的index+1，方便后续的设置tag和取图片
            
                index++
            }
            if index < 0 {  //index加1或者减1之后判断是否超出范围
            
                index = self.pageControl.numberOfPages - 1
            } else if index >= pageControl.numberOfPages {
            
                index = 0
            }
            
            imageView.tag = index
            if headData?.data?.focus?.count > 0 {
            
                imageView.sd_setImageWithURL(NSURL(string: headData!.data!.focus![index].img!), placeholderImage: placeHolderImage)
            }
        }
        //永远显示的都中间的这个imageView
        imageScrollView.contentOffset = CGPointMake(imageScrollView.width, 0)
    }
//    MARK : Timer
    private func startTimer() {
    
        timer = NSTimer(timeInterval: 3.0, target: self, selector: "next", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
//    停止定时器
    private func stopTimer() {
    
        timer?.invalidate()
        timer = nil
    }
//    Next
    func next() {
    
        imageScrollView.setContentOffset(CGPointMake(2.0 * imageScrollView.frame.size.width, 0), animated: true)
    }
//    MARK : action
    func imageViewClick(tap: UITapGestureRecognizer) {
    
        if imageClick != nil {
        
            imageClick!(index: tap.view!.tag)
        }
    }
}

// MARK:- UIScrollViewDelegate
extension PageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<imageScrollView.subviews.count {
            let imageView = imageScrollView.subviews[i] as! UIImageView
            let distance:CGFloat = abs(imageView.x - scrollView.contentOffset.x) //
            
            if distance < minDistance { //这样循环到第三回刚好把第二个ImageView的tag找到
                minDistance = distance
                page = imageView.tag
            }
        }
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updatePageScrollView()
    }
}
