//
//  OrderDetailViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 13/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    private var scrollView: UIScrollView?
    private let orderDetailView = OrderDetailView()
    private let orderUserDetailView = OrderUserDetailView()
    private let orderGoodsListView = OrderGoodsListView()
    private let evaluateView = UIView()
    private let evaluateLabel = UILabel()
    
    private lazy var starImageViews: [UIImageView] = {
        var starImageViews: [UIImageView] = []
        for i in 0...4 {
            let starImageView = UIImageView(image: UIImage(named: "v2_star_no"))
            starImageViews.append(starImageView)
        }
        return starImageViews
    }()
    
    var order: Order? {
        didSet {
            orderDetailView.order = order
            orderUserDetailView.order = order
            orderGoodsListView.order = order
            if -1 != order?.star {
                for i in 0..<order!.star {
                    let imageView = starImageViews[i]
                    imageView.image = UIImage(named: "v2_star_on")
                }
            }
            
            evaluateLabel.text = order?.comment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildScrollView()
        
        buildOrderDetailView()
        
        buildOrderUserDetailView()
        
        buildOrderGoodsListView()
        
        buildEvaluateView()
    }

    //MARK: build UI
    private func buildScrollView() {
    
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.alwaysBounceVertical = true
        scrollView?.backgroundColor = GloableBackgroundColor
        scrollView?.contentSize = CGSizeMake(ScreenWidth, 1000)
        view.addSubview(scrollView!)
    }
    private func buildOrderDetailView() {
    
        orderDetailView.frame = CGRectMake(0,10,ScreenWidth,185)
        scrollView?.addSubview(orderDetailView)
    }
    private func buildOrderUserDetailView() {
    
        orderUserDetailView.frame = CGRectMake(0, CGRectGetMaxY(orderDetailView.frame) + 10, ScreenWidth, 110)
        orderUserDetailView.delegate=self
        scrollView?.addSubview(orderUserDetailView)
    }
    private func buildOrderGoodsListView() {
    
        orderGoodsListView.frame = CGRectMake(0, CGRectGetMaxY(orderUserDetailView.frame) + 10, ScreenWidth, 350)
        orderGoodsListView.delegate = self
        scrollView?.addSubview(orderGoodsListView)
    }
    private func buildEvaluateView() {
    
        evaluateView.frame = CGRectMake(0, CGRectGetMaxY(orderGoodsListView.frame) + 10, ScreenWidth, 80)
        evaluateView.backgroundColor = UIColor.whiteColor()
        scrollView?.addSubview(evaluateView)
        
        let myEvaluateLabel = UILabel()
        myEvaluateLabel.text = "我的评价"
        myEvaluateLabel.textColor = TextBlackColor
        myEvaluateLabel.font = UIFont.systemFontOfSize(14)
        myEvaluateLabel.frame = CGRectMake(10, 5, ScreenWidth, 25)
        evaluateView.addSubview(myEvaluateLabel)
        
        for i in 0...4 {
            let starImageView = starImageViews[i]
            starImageView.frame = CGRectMake(10 + CGFloat(i) * 30, CGRectGetMaxY(myEvaluateLabel.frame) + 5, 25, 25)
            evaluateView.addSubview(starImageView)
        }
        
        evaluateLabel.font = UIFont.systemFontOfSize(14)
        evaluateLabel.frame = CGRectMake(10, CGRectGetMaxY(starImageViews[0].frame) + 10, ScreenWidth - 20, 25)
        evaluateLabel.textColor = TextBlackColor
        evaluateView.addSubview(evaluateLabel)
    }
}

//MARK: 协议实现

extension OrderDetailViewController: OrderGoodsListViewDelegate,OrderUserDetailViewDelegate {

    func orderGoodsListViewHeightDidChange(height: CGFloat) {
        orderGoodsListView.frame = CGRectMake(0, CGRectGetMaxY(orderUserDetailView.frame) + 10, ScreenWidth, height)
        evaluateView.frame = CGRectMake(0, CGRectGetMaxY(orderGoodsListView.frame) + 10, ScreenWidth, 100)
        scrollView?.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(evaluateView.frame) + 10 + 50 + NavgationH)
    }
    
    func favorateClick(tag: Int) {
        
        print(tag)
        //第二种：
        let alertController = UIAlertController(title: "通知", message: "确定还是取消", preferredStyle: UIAlertControllerStyle.Alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        
        let alertView1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("确定按钮点击事件")
            
        }
        
        let alertView2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("取消按钮点击事件")
            
        }
        
        alertController.addAction(alertView1)
        
        alertController.addAction(alertView2)
        
       // 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}




