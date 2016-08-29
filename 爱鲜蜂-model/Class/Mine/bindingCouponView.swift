//
//  bindingCouponView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 16/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class bindingCouponView: UIView {

    var bindingButtonClickBack:((couponTextField: UITextField) -> ())?
    
    private lazy var couponTextField: UITextField = {
    
        let couponTextField = UITextField()
        
        couponTextField.keyboardType = .NumberPad
        couponTextField.borderStyle = .RoundedRect
        couponTextField.autocorrectionType = .No
        couponTextField.font = UIFont.systemFontOfSize(14)
        let placeHolder = NSAttributedString(string: "请输入优惠券号码", attributes:[NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 0.8)])
        couponTextField.attributedPlaceholder = placeHolder
        
        return couponTextField
    }()
    
    private lazy var bindingButton: UIButton = {
    
       let btn = UIButton(type: UIButtonType.Custom)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = NavgationYellowColor
        btn.setTitle("绑定", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: "bindingButtonClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private lazy var lineView:UIView = {
    
        let lineView = UIView()
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.2
        
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(couponTextField)
        addSubview(bindingButton)
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, bindingButtonClickBack:((couponTextField: UITextField) -> ())) {
        self.init(frame: frame)
        
        self.bindingButtonClickBack = bindingButtonClickBack
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topBottomMargin: CGFloat = 10
        let bingdingButtonWidth: CGFloat = 60
        couponTextField.frame = CGRectMake(CouponViewControllerMargin, topBottomMargin, width - 2 * CouponViewControllerMargin - bingdingButtonWidth - 10, height - 2 * topBottomMargin)
        bindingButton.frame = CGRectMake(width - CouponViewControllerMargin - bingdingButtonWidth, topBottomMargin, bingdingButtonWidth, couponTextField.height)
        lineView.frame = CGRectMake(0, height - 0.5, width, 0.5)
    }
    
    func bindingButtonClick() {
    
        if bindingButtonClickBack != nil {
        
            bindingButtonClickBack!(couponTextField: couponTextField)
        }
    }
}
