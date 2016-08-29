//
//  LFBSegmentedControl.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 11/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class LFBSegmentedControl: UISegmentedControl {

    var segmentedClick:((index: Int) -> Void)?
    
    override init(items: [AnyObject]?) {
        super.init(items: items)
        tintColor = NavgationYellowColor
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: .Selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithCustom(100, g: 100, b: 100)], forState: .Normal)
        addTarget(self, action: "segmentedControlDidValuechange:", forControlEvents: .ValueChanged)
        selectedSegmentIndex = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(items: [AnyObject]?, didSelectedIndex:(index: Int) -> ()) {
        self.init(items:items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func segmentedControlDidValuechange(sender: UISegmentedControl) {
    
        if segmentedClick != nil {
        
            segmentedClick!(index: sender.selectedSegmentIndex)
        }
    }
    
}
