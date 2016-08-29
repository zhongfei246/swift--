//
//  CostDetailView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 22/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class CostDetailView: UIView {

    var coupon: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        buildLabel(CGRectMake(15, 0, 150, 30), text: "费用明细", font: UIFont.systemFontOfSize(12), textColor: UIColor.lightGrayColor(), textAlignment: NSTextAlignment.Left)
        
        let lineView1 = UIView(frame: CGRectMake(15, 30 - 0.5, ScreenWidth - 15, 0.5))
        lineView1.backgroundColor = UIColor.blackColor()
        lineView1.alpha = 0.1
        addSubview(lineView1)
        
        buildLabel(CGRectMake(15, 35, 100, 20), text: "商品总额", font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Left)
        buildLabel(CGRectMake(100, 35, ScreenWidth - 110, 20), text: "$" + UserShopCarTool.sharedUserShopCar.getAllProductsPrice(), font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Right)
        buildLabel(CGRectMake(15, 60, 100, 20), text: "配送费", font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Left)
        
        var distribution: String?
        
        if (UserShopCarTool.sharedUserShopCar.getAllProductsPrice() as NSString).floatValue >= 30 {
            distribution = "0"
            coupon = "5"
        } else {
            distribution = "8"
            coupon = "0"
        }
        
        buildLabel(CGRectMake(100, 60, ScreenWidth - 110, 20), text: "$" + distribution!, font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Right)
        buildLabel(CGRectMake(15, 85, 100, 20), text: "服务费", font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Left)
        buildLabel(CGRectMake(100, 85, ScreenWidth - 110, 20), text: "$0", font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Right)
        buildLabel(CGRectMake(15, 110, 100, 20), text: "优惠劵", font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Left)
        buildLabel(CGRectMake(100, 110, ScreenWidth - 110, 20), text: "$" + coupon!, font: UIFont.systemFontOfSize(14), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Right)
        
        let lineView2 = UIView(frame: CGRectMake(0, 135 - 1, ScreenWidth, 1))
        lineView2.backgroundColor = UIColor.blackColor()
        lineView2.alpha = 0.1
        addSubview(lineView2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLabel(labelFrame: CGRect, text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) {
        let label = UILabel(frame: labelFrame)
        label.text = text
        label.textAlignment = textAlignment
        label.font = font
        label.textColor = textColor
        addSubview(label)
    }

}
