//
//  BuyView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 25/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class BuyView: UIView {

    var clickAddShopCar: (() -> ())?
    var zearIsShow = false
    
    
    //添加按钮
    private lazy var addGoodsButton: UIButton = {
    
        let addGoodsButton = UIButton()
        addGoodsButton.setImage(UIImage(named: "v2_increase"), forState: .Normal)
        addGoodsButton.addTarget(self, action: "addGoodsButtonClick", forControlEvents: .TouchUpInside)
        
        return addGoodsButton
    }()
    
    //删除按钮
    private lazy var reduceGoodsButton: UIButton = {
    
        let reduceGoodsButton = UIButton(type: .Custom)
        reduceGoodsButton.setImage(UIImage(named: "v2_reduce"), forState: .Normal)
        reduceGoodsButton.addTarget(self, action: "reduceGoodsButtonClick", forControlEvents: .TouchUpInside)
        reduceGoodsButton.hidden = false
        
        return reduceGoodsButton
    }()
    
    //购买数量
    private lazy var buyCountLabel: UILabel = {
    
        let buyCountLabel = UILabel()
        
        buyCountLabel.hidden = false
        buyCountLabel.text = "0"
        buyCountLabel.textColor = UIColor.blackColor()
        buyCountLabel.textAlignment = .Center
        buyCountLabel.font = HomeCollectionTextFont
        return buyCountLabel
    }()
    
    //补货中
    private lazy var supplementLabel: UILabel = {
    
        let supplementLabel = UILabel()
        supplementLabel.text = "补货中"
        supplementLabel.hidden = true
        supplementLabel.textAlignment = .Right
        supplementLabel.textColor = UIColor.redColor()
        supplementLabel.font = HomeCollectionTextFont
        
        return supplementLabel
    }()

    private var buyNumber: Int = 0 {
    
        willSet {
        
            if newValue > 0 {
            
                reduceGoodsButton.hidden = false
                buyCountLabel.text = "\(newValue)"
            } else {
            
                reduceGoodsButton.hidden = true
                buyCountLabel.hidden = false
                buyCountLabel.text = "\(newValue)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addGoodsButton)
        addSubview(reduceGoodsButton)
        addSubview(buyCountLabel)
        addSubview(supplementLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        
        let buyCountWidth: CGFloat = 25
        addGoodsButton.frame = CGRectMake(width - height - 2, 0, height, height)
        buyCountLabel.frame = CGRectMake(CGRectGetMinX(addGoodsButton.frame) - buyCountWidth, 0, buyCountLabel.width, height)
        
        reduceGoodsButton.frame = CGRectMake(CGRectGetMinX(buyCountLabel.frame) - height, 0, height, height)
        supplementLabel.frame = CGRectMake(CGRectGetMinX(reduceGoodsButton.frame), 0, height + buyCountWidth + height, height)
    }
    
    //商品模型set方法
    var goods: Goods? {
    
        didSet {
        
            buyNumber = goods!.userBuyNumber
            
            if goods?.number <= 0 {
            
                showSupplementLabel()
            } else {
            
                hideSupplementLabel()
            }
            
            if 0 == buyNumber {
            
                reduceGoodsButton.hidden = true && !zearIsShow
                buyCountLabel.hidden = true && !zearIsShow
            } else {
            
                reduceGoodsButton.hidden = false
                buyCountLabel.hidden = false
            }
        }
    }
    //显示补货中
    private func showSupplementLabel() {
    
        supplementLabel.hidden = false
        addGoodsButton.hidden = true
        reduceGoodsButton.hidden = true
        buyCountLabel.hidden = true
    }
    //隐藏补货中，显示添加按钮
    private func hideSupplementLabel() {
    
        supplementLabel.hidden = true
        addGoodsButton.hidden = false
        reduceGoodsButton.hidden = false
        buyCountLabel.hidden = false
    }
    //按钮的相应方法
    //添加商品按钮点击
    func addGoodsButtonClick() {
    
        if buyNumber >= goods?.number {
        
            NSNotificationCenter.defaultCenter().postNotificationName(HomeGoodsInventoryProblem, object: goods?.name)
            return
        }
        reduceGoodsButton.hidden = false
        buyNumber++
        goods?.userBuyNumber = buyNumber
        buyCountLabel.text = "\(buyNumber)"
        buyCountLabel.hidden = false
        
        if clickAddShopCar != nil {
        
            clickAddShopCar!()
        }
        
        ShopCarRedDotView.sharedRedDotView.addProductToRedDotView(true)
        UserShopCarTool.sharedUserShopCar.addSupermarketProductToShopCar(goods!)
        NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarBuyPriceDidChangeNotification, object: nil, userInfo: nil)
    }
    //移除产品从购物车中
    func reduceGoodsButtonClick() {
    
        if buyNumber <= 0 { //保证购物车中有商品
        
            return
        }
        
        buyNumber--
        goods?.userBuyNumber = buyNumber
        if buyNumber == 0 {
        
            reduceGoodsButton.hidden = true && !zearIsShow
            buyCountLabel.hidden = true && !zearIsShow
            buyCountLabel.text = zearIsShow ? "0" : ""
            UserShopCarTool.sharedUserShopCar.removeSupermarketProduct(goods!)
        } else {
        
            buyCountLabel.text = "\(buyNumber)"
        }
        
        ShopCarRedDotView.sharedRedDotView.reduceProductToRedDotView(true)
        NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarBuyPriceDidChangeNotification, object: nil, userInfo: nil)
        
    }
    
    
}
