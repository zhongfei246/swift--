//
//  UIView+Category.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 28/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import Foundation

// MARK: - 对UIView的扩展
extension UIView {

    //x值
    var x: CGFloat {
    
        return self.frame.origin.x
    }
    //y值
    var y: CGFloat {
    
        return self.frame.origin.y
    }
    //宽
    var width: CGFloat {
    
        return self.frame.size.width
    }
    //高
    var height: CGFloat {
    
        return self.frame.size.height
    }
    //size
    var size: CGSize {
    
        return self.frame.size
    }
    //point
    var point: CGPoint {
    
        return self.frame.origin
    }
}
