//
//  LFBCollectionView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class LFBCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        delaysContentTouches = false  //delaysContentTouches。默认值为YES；如果设置为NO，则无论手指移动的多么快，始终都会将触摸事件传递给内部控件；设置为NO可能会影响到UIScrollView的滚动功能。
        canCancelContentTouches = true  //简单通俗点说，如果为YES，就会等待用户下一步动作，如果用户移动手指到一定距离，就会把这个操作作为滚动来处理并开始滚动，同时发送一个touchesCancelled:withEvent:消息给内容控件，由控件自行处理。如果为NO，就不会等待用户下一步动作，并始终不会触发scrollView的滚动了。
        
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") {
        
            for gesture in wrapView!.gestureRecognizers! {
            
                if (NSStringFromClass(gesture.classForCoder).containsString("DelayedTouchesBegan")) {
                
                    gesture.enabled = false
                    break
                }
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        if view.isKindOfClass(UIControl) {
        
            return true
        }
        
        return super.touchesShouldCancelInContentView(view)
    }
}
