//
//  HomeCollectionFooterView.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 25/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class HomeCollectionFooterView: UICollectionReusableView {
    
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "点击查看更多商品 ->"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.colorWithCustom(150, g: 150, b: 150)
        titleLabel.font = UIFont.systemFontOfSize(16.0)
        titleLabel.frame = CGRectMake(0, 0, ScreenWidth, 60)
        
        addSubview(titleLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideLabel() {
    
        self.titleLabel.hidden = true
    }
    
    func displayLabel() {
    
        self.titleLabel.hidden = false
    }
    
    func setFooterTitle(text: String, textColor: UIColor) {
    
        titleLabel.text = text
        titleLabel.textColor = textColor
    }
    
}

class HomeCollectionHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "新鲜热卖"
        titleLabel.textColor = UIColor.colorWithCustom(150, g: 150, b: 150)
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        titleLabel.textAlignment = .Center
        titleLabel.frame = CGRectMake(10, 0, 200, 20)
        
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
