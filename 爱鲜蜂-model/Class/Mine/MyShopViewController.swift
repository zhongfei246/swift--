//
//  MyShopViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 19/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class MyShopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的店铺"
        
        let imageView = UIImageView(image: UIImage(named: "v2_store_empty"))
        imageView.center = CGPointMake(view.center.x, view.center.y - 150)
        view.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRectMake(0,CGRectGetMaxY(imageView.frame)+10,view.width,30))
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "还没有收藏店铺哦！"
        view.addSubview(titleLabel)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
