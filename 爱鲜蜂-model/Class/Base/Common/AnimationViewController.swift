//
//  AnimationViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 7/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController {

    var animationLayers: [CALayer]?
    
    var animationBigLabyers: [CALayer]?
    
    //MARK : 商品添加到购物车动画
    func addProductsAnimation(imageView: UIImageView) {
    
        if (self.animationLayers == nil) {
        
            self.animationLayers = [CALayer]()
        }
        
        //截图
        let frame = imageView.convertRect(imageView.bounds, toView: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        
        self.view.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
        
        //规划组成动画路线的点
        let p1 = transitionLayer.position
        let p3 = CGPointMake(view.width - view.width / 4 - view.width / 8 - 6, self.view.layer.bounds.size.height - 40)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, p1.x, p1.y)
        CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y, p3.x, p3.y)
        positionAnimation.path = path
        
        //透明度动画 fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards//当动画结束后,layer会一直保持着动画最后的状态
        opacityAnimation.removedOnCompletion = true
        
        //缩小动画
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(CATransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        //把所有动画放到组中执行
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation,transformAnimation,opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self
        
        transitionLayer.addAnimation(groupAnimation, forKey: "cartParabola")
        
    }

    //MARK: - 添加商品到右下角购物车动画
    func addProductsToBigShopCarAnimation(imageView: UIImageView) {
    
        if animationBigLabyers == nil {
        
            animationBigLabyers = [CALayer]()
        }
        
        let frame = imageView.convertRect(imageView.bounds, toView: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        
        self.view.layer.addSublayer(transitionLayer)
        self.animationBigLabyers?.append(transitionLayer)
        
        let p1 = transitionLayer.position
        let p3 = CGPointMake(view.width - 40, self.view.layer.bounds.size.height - 40)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, p1.x, p1.y)
        CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y)
        positionAnimation.path = path
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.removedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(CATransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation,transformAnimation,opacityAnimation]
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self
        
        transitionLayer.addAnimation(groupAnimation, forKey: "BigShopCarAnimaiton")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if self.animationLayers?.count > 0 {
        
            let transitionLayer = animationLayers![0]
            transitionLayer.hidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayers?.removeFirst()
            
            view.layer.removeAnimationForKey("cartParabola")
        }
        
        if self.animationBigLabyers?.count > 0 {
        
            let transitionLayer = animationBigLabyers![0]
            transitionLayer.hidden = true
            transitionLayer.removeFromSuperlayer()
            animationBigLabyers?.removeFirst()
            
            view.layer.removeAnimationForKey("BigShopCarAnimaiton")
        }
    }
    

}
