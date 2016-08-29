//
//  IconImageTextView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class IconImageTextView: UIView {

    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?
    
    var activities: Activities? {
    
        didSet {
        
            textLabel?.text = activities?.name
            imageView?.sd_setImageWithURL(NSURL(string: activities!.img!)!, placeholderImage: placeholderImage)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.userInteractionEnabled = false
        imageView?.contentMode = UIViewContentMode.Center
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = .Center
        textLabel!.font = UIFont.systemFontOfSize(12.0)
        textLabel!.textColor = UIColor.blackColor()
        textLabel!.userInteractionEnabled = false
        addSubview(textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(5, 5, width - 15, height - 30)
        textLabel?.frame = CGRectMake(5, height - 25, imageView!.width, 20)
    }

}
