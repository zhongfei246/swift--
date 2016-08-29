//
//  UserShopCarTool.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 27/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class UserShopCarTool: NSObject {

    private static let instance = UserShopCarTool()
    private var supermarketProduct = [Goods]()
    
    class var sharedUserShopCar: UserShopCarTool {
       
        return instance
        
    }
    //用户购物车产品数量
    func userShopCarProductsNumber() -> Int {
    
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    //是否为空
    func isEmpty() -> Bool {
    
        return supermarketProduct.count == 0
    }
    //添加商品到购物车
    func addSupermarketProductToShopCar(good: Goods) {
    
        for everyGoods in supermarketProduct {
            
            if everyGoods.id == good.id {
            
                return
            }
        }
        
        supermarketProduct.append(good)
    }
    //获取购物车中的物品
    func getShopCarProducts() -> [Goods] {
    
        return supermarketProduct
    }
    //获取数量
    func getShopCarproductsClassifNumber() -> Int {
    
      return supermarketProduct.count
    }
    //从购物车中移除商品
    func removeSupermarketProduct(goods: Goods) {
    
        for i in 0..<supermarketProduct.count {
        
            let everyGoods = supermarketProduct[i]
            if everyGoods.id == goods.id {
            
                supermarketProduct.removeAtIndex(i)
                NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarDidRemoveProductNSNotification, object: nil, userInfo: nil)
                return
            }
        }
    }
    //获取所有产品的价格
    func getAllProductsPrice() -> String {
    
        var allPrice: Double = 0
        for goods in supermarketProduct {
        
            allPrice = allPrice + Double(goods.partner_price!)! * Double(goods.userBuyNumber)
        }
        
        return "\(allPrice)".cleanDecimalPointZear()
    }
}
