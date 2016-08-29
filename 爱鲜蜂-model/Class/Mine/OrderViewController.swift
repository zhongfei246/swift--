//
//  OrderViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 10/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class OrderViewController: BaseViewController {

    private var tableView:LFBTableView!
    var orders: [Order]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的订单"
        
        buildOrderTableView()
    }

    //MARK: build UI
    private func buildOrderTableView() {
    
        tableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        view.addSubview(tableView)
        
        loadOrderData()
    }

    private func loadOrderData() {
    
        weak var tempSelf = self
        OrderData.loadOrderData { (data ,error) -> Void in
        
            tempSelf!.orders = data?.data
            tempSelf!.tableView.reloadData()
        }
    }
}

//MARK: tableview的协议实现
extension OrderViewController: UITableViewDataSource,UITableViewDelegate,MyOrderCellDelegate {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MyOrderCell.muOrderCell(tableView, indexPath: indexPath)
        cell.order = orders![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 185.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func orderCellButtonDidClick(IndexPath: NSIndexPath, buttonType: Int) {
        print(buttonType, IndexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderDetailVC = OrderStatusViewController()
        orderDetailVC.order  = orders![indexPath.row]
        navigationController?.pushViewController(orderDetailVC, animated: true)
    }
    
}