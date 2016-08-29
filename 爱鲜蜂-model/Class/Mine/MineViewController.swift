//
//  MineViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 17/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    private var headView: MineHeadView!
    private var headViewHeight:CGFloat = 150
    private var tableView:LFBTableView!
    private var tableViewHeadView:MineTableHeadView!
    private var couponNum: Int = 0
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
    
    var iderVCSendIderSuccess = false
    
    private lazy var mines: [MineCellModel] = {
    
        let mines = MineCellModel.loadMineCellModes()
        return mines
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.hidden = true
        
        //创建UI
        buildUI()
    }
    override func loadView() {
        super.loadView()//调用这一行返回给self.view一个系统view的，在这个函数中也可以自己定义view赋值给self.view。当调用self.view发现为nil时会调用这个函数
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    //build UI   到这：创建我界面的UI
    private func buildUI() {
      
        weak var tempSelf = self
        headView = MineHeadView(frame: CGRectMake(0, 0, ScreenWidth, headViewHeight), settingButtonClick: { () -> Void in
           
            let settingVC = SettingViewController()
            tempSelf?.navigationController?.pushViewController(settingVC, animated: true)
        })
        view.addSubview(headView)
        
        buildTableView()
    }
    private func buildTableView() {
    
        tableView = LFBTableView(frame: CGRectMake(0, headViewHeight, ScreenWidth, ScreenHeight - headViewHeight), style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 46
        view.addSubview(tableView)
        
        weak var tempSelf = self
        tableViewHeadView = MineTableHeadView(frame: CGRectMake(0,0,ScreenWidth,70))
        //headerView的回调
        tableViewHeadView.mineHeadViewClick = { (type) -> () in
            switch type {
            
            case .Order://我的订单
                let orderVc = OrderViewController()
                tempSelf!.navigationController?.pushViewController(orderVc, animated: true)
                break
            case .Coupon://优惠券
                let couponVC = CouponViewController()
                tempSelf!.navigationController!.pushViewController(couponVC, animated: true)
                break
            case .Message://我的消息
                let message = MessageViewController()
                tempSelf!.navigationController?.pushViewController(message, animated: true)
                break
            }
        }
        tableView.tableHeaderView = tableViewHeadView
    }

}

//MARK: -UITableViewDataSource UITableViewDelegate
extension MineViewController: UITableViewDataSource,UITableViewDelegate,IdeaViewControllerDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MineCell.cellFor(tableView)
        
        if 0 == indexPath.section {
        
            cell.mineModel = mines[indexPath.row]
        } else if 1 == indexPath.section {
            
            cell.mineModel = mines[2]
        } else {
        
            if indexPath.row == 0 {
            
                cell.mineModel = mines[3]
            } else {
            
                cell.mineModel = mines[4]
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let adressVC = MyAdressViewController()
                navigationController?.pushViewController(adressVC, animated: true)
            } else {
                let myShopVC = MyShopViewController()
                navigationController?.pushViewController(myShopVC, animated: true)
            }
        } else if 1 == indexPath.section {
            shareActionSheet.showActionSheetViewShowInView(view) { (shareType) -> () in
                ShareManager.shareToShareType(shareType, vc: self)
            }
        } else if 2 == indexPath.section {
            if 0 == indexPath.row {
                let helpVc = HelpViewController()
                navigationController?.pushViewController(helpVc, animated: true)
            } else if 1 == indexPath.row {
                let ideaVC = IdeaViewController()
                ideaVC.delegate = self
                navigationController!.pushViewController(ideaVC, animated: true)
            }
        }
    }
    
    //意见界面的协议：主要用于成功后的提示，当然那个界面用延时1秒模仿请求接口上传数据然后返回在这个界面做成功提示（定义个协议主要用于以后扩展使用）
    func sendSuggestionSuceesMarkToMineVC() {
        ProgressHUDManager.showSuccessWithStatus("已经收到你的意见了,我们会改正的,放心吧~~")
    }
}
