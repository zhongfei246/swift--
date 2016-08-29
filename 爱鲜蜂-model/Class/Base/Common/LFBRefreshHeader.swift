//
//  LFBRefreshHeader.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 25/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class LFBRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        
        stateLabel?.hidden = false
        lastUpdatedTimeLabel?.hidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: .Idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: .Pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!,UIImage(named: "v2_pullRefresh2")!], forState: .Refreshing)

        
        setTitle("下拉刷新", forState: .Idle)
        setTitle("松开手开始刷新", forState: .Pulling)
        setTitle("正在刷新", forState: .Refreshing)
    }

}
