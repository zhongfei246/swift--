//
//  OrderUserDetailView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 15/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

protocol OrderUserDetailViewDelegate: NSObjectProtocol {

    func favorateClick(tag: Int)
}


class OrderUserDetailView: UIView {

    let consigneeLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let consigneeAdressLabel = UILabel()
    let lineView = UIView()
    let shopLabel = UILabel()
    let collectionButton = UIButton()
    
    weak var delegate:OrderUserDetailViewDelegate?
    
    var order: Order? {
    
        didSet {
        
            consigneeLabel.text = "收 货 人:  " + (order?.accept_name)!
            phoneNumberLabel.text = order?.telphone
            consigneeAdressLabel.text = "收货地址:    "  + (order?.address)!
            shopLabel.text = "配送店铺    " + (order?.dealer_name)!
        }
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        consigneeLabel.textColor = TextBlackColor
        consigneeLabel.font = UIFont.systemFontOfSize(14)
        addSubview(consigneeLabel)
        
        consigneeAdressLabel.textColor = TextBlackColor
        consigneeAdressLabel.font = UIFont.systemFontOfSize(12)
        addSubview(consigneeAdressLabel)
        
        phoneNumberLabel.textColor = TextBlackColor
        phoneNumberLabel.font = UIFont.systemFontOfSize(12)
        phoneNumberLabel.textAlignment = .Right
        addSubview(phoneNumberLabel)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        lineView.alpha = 0.1
        addSubview(lineView)
        
        shopLabel.textColor = TextBlackColor
        shopLabel.font = UIFont.systemFontOfSize(12)
        addSubview(shopLabel)
        
        collectionButton.setTitle("+ 收藏", forState: .Normal)
        collectionButton.setTitleColor(TextBlackColor, forState: .Normal)
        collectionButton.setTitle("取消收藏", forState: .Selected)
        collectionButton.setBackgroundImage(UIImage.imageWithColor(NavgationYellowColor, size: CGSizeMake(60, 25), alpha: 1), forState: .Normal)
        collectionButton.setBackgroundImage(UIImage.imageWithColor(NavgationYellowColor, size: CGSizeMake(60, 25), alpha: 1), forState: .Selected)
        collectionButton.layer.cornerRadius = 5
        collectionButton.layer.masksToBounds = true
        collectionButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        collectionButton.addTarget(self, action: "favoriteClick:", forControlEvents: .TouchUpInside)
        addSubview(collectionButton)
    }

    func favoriteClick(btn: UIButton) {
    
//        let alert = UIAlertView() 第一种提示的写法（不提倡使用的alertView）
//        alert.title = "提示"
//        alert.message = "确定要收藏？"
//        alert.delegate = self
//        alert.addButtonWithTitle("确定") //buttonIndex 0（顺序从左到右显示，下标从0开始）
//        alert.addButtonWithTitle("取消") //buttonIndex 1
//        alert.show()
        
        //第二种：需要在控制器中
        if self.delegate != nil {
        
            self.delegate?.favorateClick(btn.tag)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin:CGFloat = 10
        let labelHeight: CGFloat = 30
        consigneeLabel.frame = CGRectMake(leftMargin, 5, width * 0.5, labelHeight)
        phoneNumberLabel.frame = CGRectMake(width - width * 0.4 - 10, 5, width * 0.4, labelHeight)
        consigneeAdressLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeLabel.frame), width - 20, labelHeight)
        lineView.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeAdressLabel.frame) + 5, width - leftMargin, 1)
        shopLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(lineView.frame), width * 0.6, 40)
        collectionButton.frame = CGRectMake(width - 60 - 10, CGRectGetMaxY(lineView.frame) + (40 - 25) * 0.5, 60, 25)
    }

}

//第一种提示的alerView
//extension OrderUserDetailView: UIAlertViewDelegate {
//
//    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//        print(buttonIndex)
//    }
//}

