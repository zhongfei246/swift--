//
//  UIColor+Category.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 25/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import Foundation

extension UIColor {

    class func colorWithCustom(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
    
        return UIColor(red: r / 255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        
        return UIColor.colorWithCustom(r, g: g, b: b)
    }
}
