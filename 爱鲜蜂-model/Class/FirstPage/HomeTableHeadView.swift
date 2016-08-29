//
//  HomeTableHeadView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class HomeTableHeadView: UIView {

    private var pageScrollView: PageScrollView?
    private var hotView: HotView?
    weak var delegate: HomeTableHeadViewDelegate?
    var tableHeadViewHeight: CGFloat = 0 {
    
        willSet {
        
            NSNotificationCenter.defaultCenter().postNotificationName(HomeTableHeadViewHeightDidChange, object: newValue)
            frame = CGRectMake(0, -newValue, ScreenWidth, newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //上面的轮播
        buildPageScrollView()
        //轮播下面的那些选项按钮（一行四个，有多少个根据网络请求数据而定）
        buildHotView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headData: HeadResources? {
    
        didSet {
        
         pageScrollView?.headData = headData
            hotView!.headData = headData?.data
        }
    }
    
//    MARK -初始化子控件  轮播
    func buildPageScrollView() {
    
        weak var tempSelf = self
        pageScrollView = PageScrollView(frame: CGRectZero, placeholder: UIImage(named: "v2_placeholder_full_size")!, focusImageViewClick: { (index) -> Void in
            
            if tempSelf!.delegate != nil && ((tempSelf!.delegate?.respondsToSelector("tableHeadView:focusImageViewClick:")) != nil)  {
            
                tempSelf!.delegate!.tableHeadView!(tempSelf!, focusImageViewClick: index)
            }
        
        })
        addSubview(pageScrollView!)
    }
    //轮播下面的选项
    func buildHotView() {
    
        weak var tempSelf = self
        hotView = HotView(frame: CGRectZero, iconClick: { (index) -> Void in
            if tempSelf!.delegate != nil && ((tempSelf?.delegate?.respondsToSelector("tableHeadView:iconClick:")) != nil) {
            
                tempSelf!.delegate!.tableHeadView!(tempSelf!, iconClick: index)
            }
        })
        hotView?.backgroundColor = UIColor.whiteColor()
        addSubview(hotView!)
    }
    
//    MARK 布局子控件
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        pageScrollView?.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth * 0.31)
        
        hotView?.frame.origin = CGPointMake(0, CGRectGetMaxY((pageScrollView?.frame)!))
        
        tableHeadViewHeight = CGRectGetMaxY(hotView!.frame)
    }
}
//MARK - Delegate
@objc protocol HomeTableHeadViewDelegate: NSObjectProtocol {

    optional func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int)
    
    optional func tableHeadView(headView: HomeTableHeadView, iconClick index: Int)
}