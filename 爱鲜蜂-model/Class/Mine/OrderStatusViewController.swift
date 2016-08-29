//
//  OrderStatusViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 11/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class OrderStatusViewController: BaseViewController {

    private var orderDetailTableView: LFBTableView?
    private var segment: LFBSegmentedControl!
    private var orderDetailVC:OrderDetailViewController?
    private var orderStatuses:[OrderStatus]? {
    
        didSet {
        
            orderDetailTableView?.reloadData()
        }
    }
    
    var order:Order? {
    
        didSet {
        
            orderStatuses = order?.status_timeline
            
            if order?.detail_buttons?.count > 0 {
                let btnWidth: CGFloat = 80
                let btnHeight: CGFloat = 30
                for i in 0..<order!.detail_buttons!.count { //底部的类似删除订单按钮
                    let btn = UIButton(frame: CGRectMake(view.width - (10 + CGFloat(i + 1) * (btnWidth + 10)), view.height - 50 - NavgationH + (50 - btnHeight) * 0.5, btnWidth, btnHeight))
                    btn.setTitle(order!.detail_buttons![i].text, forState: UIControlState.Normal)
                    btn.backgroundColor = NavgationYellowColor
                    btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    btn.titleLabel?.font = UIFont.systemFontOfSize(13)
                    btn.layer.cornerRadius = 5;
                    btn.tag = order!.detail_buttons![i].type
                    btn.addTarget(self, action: "detailButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
                    view.addSubview(btn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavigationItem()
        
        buildOrderDetailTableview()
        
//        buildDetailButtonsView()
    }

    //build UI
    private func buildNavigationItem() {
    
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("投诉", titleColor:TextBlackColor, target: self, action: "rightItemButtonClick")
        weak var tempSelf = self
        segment = LFBSegmentedControl(items: ["订单状态","订单详情"], didSelectedIndex: { (index) -> () in
            if index == 0 {
            
                tempSelf!.showOrderStatusView()
            } else if index == 1 {
            
                tempSelf!.showOrderDetailView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRectMake(0, 5, 180, 27)
    }
    private func buildOrderDetailTableview() {
    
        orderDetailTableView = LFBTableView(frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavgationH),style: .Plain)
        orderDetailTableView?.dataSource = self
        orderDetailTableView?.delegate = self
        orderDetailTableView?.backgroundColor = UIColor.whiteColor()
        orderDetailTableView?.rowHeight = 80
        view.addSubview(orderDetailTableView!)
    }
    private func buildDetailButtonsView() {
    
        let buttomView = UIView(frame: CGRectMake(0,view.height - 50 - NavgationH,view.width,1))
        buttomView.backgroundColor = UIColor.grayColor()
        buttomView.alpha = 0.1
        view.addSubview(buttomView)
    }
    
    //MARK: - Action
    func rightItemButtonClick() {
    
        
    }
    func detailButtonClick(sender: UIButton) {
    
        print("点击了底部按钮 类型是"+"\(sender.tag)")
    }
    
    func showOrderStatusView() {
    
        weak var tempSelf = self
        tempSelf!.orderDetailVC!.view.hidden = true
        tempSelf!.orderDetailTableView?.hidden = false
    }
    
    func showOrderDetailView() {
        weak var tmpSelf = self
        if tmpSelf!.orderDetailVC == nil {
            tmpSelf!.orderDetailVC = OrderDetailViewController()
            tmpSelf!.orderDetailVC?.view.hidden = false
            tmpSelf!.orderDetailVC?.order = order
            tmpSelf!.addChildViewController(orderDetailVC!)
            tmpSelf!.view.insertSubview(orderDetailVC!.view, atIndex: 0)
        } else {
            tmpSelf!.orderDetailVC?.view.hidden = false
        }
        tmpSelf!.orderDetailTableView?.hidden = true
    }
}

//MARK:UITableViewDelegate, UITableViewDataSource

extension OrderStatusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = OrderStatusCell.orderStatusCell(tableView)
        cell.orderStatus = orderStatuses![indexPath.row]
        //cell中的左边圆圈和线：每个cell的线分为两部分，第一部分是圆圈上面的那段，第二部分是圆圈下面的那段
        if indexPath.row == 0 {
            cell.orderStateType = .Top
        } else if indexPath.row == orderStatuses!.count - 1 {
            cell.orderStateType = .Bottom
        } else {
            cell.orderStateType = .Middle
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatuses?.count ?? 0
    }
}
