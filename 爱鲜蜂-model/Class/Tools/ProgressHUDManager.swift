//
//  ProgressHUDManager.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 27/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class ProgressHUDManager {

    class func setBackgroundColor(color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    class func setForegroundColor(color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    class func setSuccessImage(image: UIImage) {
        SVProgressHUD.setSuccessImage(image)
    }
    
    class func setErrorImage(image: UIImage) {
        SVProgressHUD.setErrorImage(image)
    }
    
    class func setFont(font: UIFont) {
        SVProgressHUD.setFont(UIFont.systemFontOfSize(16))
    }
    
    class func showImage(image: UIImage, status: String) {
        SVProgressHUD.showImage(image, status: status)
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func showWithStatus(status: String) {
        SVProgressHUD.showWithStatus(status)
    }
    
    class func isVisible() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    class func showSuccessWithStatus(string: String) {
        SVProgressHUD.showSuccessWithStatus(string)
    }
}
