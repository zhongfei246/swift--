//
//  DiscountPriceView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 25/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class DiscountPriceView: UIView {

    private var markPriceLabel: UILabel?
    private var priceLabel: UILabel?
    private var lineView: UIView?
    private var hasMarketPrice = false
    
    var priceColor: UIColor? {
    
        didSet {
        
            if priceLabel != nil {
            
                priceLabel!.textColor = priceColor
            }
        }
    }
    
    var marketPriceColor: UIColor? {
    
        didSet {
        
            if markPriceLabel != nil {
            
                markPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                
                    lineView!.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        markPriceLabel = UILabel()
        markPriceLabel?.textColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        markPriceLabel?.font = HomeCollectionTextFont
        addSubview(markPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        markPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel!.textColor = UIColor.redColor()
        priceLabel?.font = HomeCollectionTextFont
        addSubview(priceLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    convenience init(price: String?, marketPrice: String?) {
        self.init()
        
        if price != nil && price?.characters.count != 0 {
        
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        
        if marketPrice != nil && marketPrice?.characters.count != 0 {
        
            markPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            markPriceLabel?.sizeToFit()
        } else {
        
            hasMarketPrice = false
        }
        
        //如果价格相等
        if marketPrice == price {
        
            hasMarketPrice = false
        } else {
        
            hasMarketPrice = true
        }
        
        markPriceLabel?.hidden = !hasMarketPrice
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        
        priceLabel?.frame = CGRectMake(0, 0, priceLabel!.width, height)
        if hasMarketPrice {
        
            markPriceLabel?.frame = CGRectMake(CGRectGetMaxX(priceLabel!.frame) + 5, 0, markPriceLabel!.width, height)
            
            lineView?.frame = CGRectMake(0, markPriceLabel!.height * 0.5 - 0.5, markPriceLabel!.width, 1)
        }
    }

}
