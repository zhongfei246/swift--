//
//  ADViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 25/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {

    
    private lazy var backImageView: UIImageView = {
    
        let backImageView = UIImageView()
        backImageView.frame = ScreenBounds
        return backImageView
    }()
    
    var imageName: String? {
    
        didSet {
        
            var placeHolderImageName: String?
            switch UIDevice.currentDeviceScreenMeasurement() {
            
            case 3.5:
                placeHolderImageName = "iphone4"
            case 4.0:
                placeHolderImageName = "iphone5"
            case 4.7:
                placeHolderImageName = "iphone6"
            default:
                placeHolderImageName = "iphone6plus"
            }
            backImageView.sd_setImageWithURL(NSURL(string: imageName!), placeholderImage: UIImage(named: placeHolderImageName!), completed: {(image, error,_,_) -> Void in
            
                if error != nil {

                    //加载广告失败
                    print("加载广告失败")
                    NSNotificationCenter.defaultCenter().postNotificationName(ADimageLoadFail, object: nil)
                }
                
                if image != nil {
                
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)//状态栏收起
                        
                        let time1 = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
                        dispatch_after(time1, dispatch_get_main_queue(), { () -> Void in
                            NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadSecussed, object: image)//发送成功通知
                        })
                    })
                } else {
                
                    //加载广告失败
                    print("加载广告失败")
                    NSNotificationCenter.defaultCenter().postNotificationName(ADimageLoadFail, object: nil)
                }
                
            })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backImageView)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
    }

    

}
