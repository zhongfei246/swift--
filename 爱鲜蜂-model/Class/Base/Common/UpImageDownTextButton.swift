//
//  UpImageDownTextButton.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 9/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class UpImageDownTextButton: UIButton {

    override func layoutSubviews() {
         super.layoutSubviews()
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(0, height - 15, width, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(0, 0, width, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
    }
}

//navigation的左边item
class ItemLeftButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let Offset: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-Offset, height - 15, width - Offset, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(-Offset, 0, width - Offset, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
    }
}
//navigation的右边item
class ItemRightButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offSet: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(offSet, height - 15, width + offSet, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
        
        imageView?.frame = CGRectMake(offSet, 0, width + offSet, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
        
    }
}

class ItemLeftImageButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = bounds
        imageView?.frame.origin.x = -15
    }
}
