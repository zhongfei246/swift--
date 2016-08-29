//
//  MessageViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 10/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    private var segment: LFBSegmentedControl!
    private var systemTableView: LFBTableView!
    private var systemMessage:[userMessage]?
    private var UserMessage:[userMessage]?
    private var secondView: UIView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildSystemTableView()
        
        buildSecondView()
        
        buildSegmentControl()
        
        showSystemTableView()
        
        loadSystemMessage()
    }
    
    //MARK: build UI
    private func buildSystemTableView() {
    
        systemTableView = LFBTableView(frame: view.bounds, style: .Plain)
        systemTableView.backgroundColor = GloableBackgroundColor
        systemTableView.showsHorizontalScrollIndicator = false
        systemTableView.showsVerticalScrollIndicator = false
        systemTableView.delegate = self
        systemTableView.dataSource = self
        systemTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        view.addSubview(systemTableView)
        
        //导入数据
        loadSystemTableViewData()
    }
    private func loadSystemTableViewData() {
    
        weak var tempSelf = self
        userMessage.loadSystemMessage { (data, error) -> () in
            tempSelf!.systemMessage = data
            tempSelf!.systemTableView.reloadData()
        }
    }
    private func buildSecondView() {
    
        secondView = UIView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight - 64))
        secondView?.backgroundColor = GloableBackgroundColor
        view.addSubview(secondView!)
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_my_message_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        secondView?.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "~~~然，并没有消息~~~"
        normalLabel.textAlignment = .Center
        normalLabel.frame = CGRectMake(0, CGRectGetMaxY(normalImageView.frame)+10, ScreenWidth, 50)
        secondView?.addSubview(normalLabel)
        
    }
    private func buildSegmentControl() {
    
        weak var tempSelf = self
        segment = LFBSegmentedControl(items: ["系统消息","用户消息"],didSelectedIndex: { (index) -> () in
            
            if 0 == index {
            
                tempSelf!.showSystemTableView()
            } else if 1 == index {
            
                tempSelf!.showUserTableView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRectMake(0,5,180,27)
    }
    private func showSystemTableView() {
    
        secondView?.hidden = true
    }
    private func showUserTableView() {
    
        secondView?.hidden = false
    }
    
    private func loadSystemMessage() {
    
       weak var tempSelf = self
        userMessage.loadSystemMessage { (data, error) -> () in
            tempSelf!.systemMessage = data
            tempSelf!.systemTableView.reloadData()
        }
    }
}

//MARK: 协议实现
extension MessageViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = systemMessageCell.createSystemMessageCell(tableView)
        cell.message = systemMessage![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemMessage?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = systemMessage![indexPath.row]
        
        return message.cellHeight
    }
    
}

