//
//  LFBTableView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 12/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class LFBTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        delaysContentTouches = false
        canCancelContentTouches = true
        separatorStyle = .None
        
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") { //ios7上面的tableview上的WrapperView，由cell通过superview找tableview时需要注意多加一层superview（ios7和以后不太一样，不过ios7几乎被淘汰）
        
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
