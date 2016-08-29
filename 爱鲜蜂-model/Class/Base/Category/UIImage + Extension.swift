//
//  UIImage + Extension.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 16/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

extension UIImage {

    //通过上下文和参数属性返回图片image
    class func imageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(rect.size)//创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)。参数size为新创建的位图上下文的大小。它同时是由UIGraphicsGetImageFromCurrentImageContext函数返回的图形大小。
        let ref = UIGraphicsGetCurrentContext()
        CGContextSetAlpha(ref, alpha)
        CGContextSetFillColorWithColor(ref, color.CGColor)
        CGContextFillRect(ref, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //直接通过上下文返回Image
    class func createImageFromView(view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func imageClipOvalImage() -> UIImage {
    
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextAddEllipseInRect(ctx, rect)//在指定的矩形内添加一个椭圆
        CGContextClip(ctx)//说白了就是切图按照path（如果没有path，则此函数没有用(这里貌似没有设置Path，所以感觉没有用此函数（对比下面的例子）)，具体可对照下面的这个可将视图剪裁成一个圆形或者椭圆）
        
        self.drawInRect(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
        
        /**
        *  以下可讲视图裁剪成一个圆形或椭圆：
        
        - (void) drawRect: (CGRect) aRect
        {
        UIImage *logo = [UIImageimageNamed:@"logo1.png"];
        CGRect bounds = CGRectMake(0.0f, 0.0f,rect.origin.x + aRect.size.width, rect.origin.y + aRect.size.height);
        // Create a new path
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        
        // Add circle to path
        CGPathAddEllipseInRect(path, NULL, bounds);//这句话就是剪辑作用
        CGContextAddPath(context, path);
        
        // Clip to the circle and draw the logo
        CGContextClip(context);
        [logo drawInRect:bounds];
        CFRelease(path);
        }
        */
    }
    
}
