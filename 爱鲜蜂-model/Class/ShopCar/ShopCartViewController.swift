//
//  ShopCartViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 28/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class ShopCartViewController: BaseViewController {

    let userShopCar = UserShopCarTool.sharedUserShopCar
    
    private let shopImageView         = UIImageView()
    private let emptyLabel            = UILabel()
    private let emptyButton           = UIButton(type: .Custom)
    private var receiptAdressView: ReceiptAddressView?
    private var tableHeadView         = UIView()
    private let signTimeLabel         = UILabel()
    private let reserveLabel          = UILabel()
    private let signTimePickerView    = UIPickerView()
    private let commentsView          = ShopCartCommentsView()
    private let supermarketTableView  = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50), style: .Plain)
    private let tableFooterView       = ShopCartSupermarketTableFooterView()//选好了的那一栏view
    private var isFristLoadData       = false

    private func showShopCarEmptyUI() {
    
        shopImageView.hidden = false
        emptyButton.hidden = false
        emptyLabel.hidden = false
        supermarketTableView.hidden = true
    }
    
    private func showProductView() {
    
        if !isFristLoadData {
        
            buildTableHeadView()
            
            buildSupermarketTableView()
            
            isFristLoadData = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        commentsView.textField.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add通知
        addNotification()
        
        //navigationItem
        buildNavigationItem()
        
        //build empty UI
        buildEmptyUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        weak var tempSelf = self
        if userShopCar.isEmpty() {
           
           showShopCarEmptyUI()
        } else {
        
            if !ProgressHUDManager.isVisible() {
            
                ProgressHUDManager.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
                ProgressHUDManager.showWithStatus("正在加载商品信息")
            }
            
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                tempSelf!.showProductView()
                ProgressHUDManager.dismiss()
            })
        }
        
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK:添加通知
    private func addNotification() {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarProductsDidRemove", name: LFBShopCarDidRemoveProductNSNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyPriceDidChange", name: LFBShopCarBuyPriceDidChangeNotification, object: nil)
    }

    //MARK:通知辅助函数(LFBShopCarDidRemoveProductNSNotification)
    func shopCarProductsDidRemove() {
    
        if UserShopCarTool.sharedUserShopCar.isEmpty() {
        
            showShopCarEmptyUI()
        }
        
        self.supermarketTableView.reloadData()
    }
    //MARK:通知辅助函数(LFBShopCarBuyPriceDidChangeNotification)
    func shopCarBuyPriceDidChange() {
    
        tableFooterView.priceLabel.text = UserShopCarTool.sharedUserShopCar.getAllProductsPrice()
    }
    
    //MARK:导航栏设置
    func buildNavigationItem() {
    
        navigationItem.title = "购物车"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(UIImage(named: "v2_goback")!, target: self, action: "leftNavigitonItemClick")
    }
    //MARK:辅助函数（左边点击）
    func leftNavigitonItemClick() {
    
        NSNotificationCenter.defaultCenter().postNotificationName(LFBShopCarBuyProductNumberDidChangeNotification, object: nil, userInfo: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:空数据UI
    private func buildEmptyUI() {
    
        shopImageView.image = UIImage(named: "v2_shop_empty")
        shopImageView.contentMode = .Center
        shopImageView.frame = CGRectMake((view.width - shopImageView.width) * 0.5, view.height * 0.25, shopImageView.width, shopImageView.height)
        shopImageView.hidden = true
        view.addSubview(shopImageView)
        
        emptyLabel.text = "亲,购物车空空的耶~赶紧挑好吃的吧"
        emptyLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        emptyLabel.textAlignment = NSTextAlignment.Center
        emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(shopImageView.frame) + 55, view.width, 50)
        emptyLabel.font = UIFont.systemFontOfSize(16)
        emptyLabel.hidden = true
        view.addSubview(emptyLabel)
        
        emptyButton.frame = CGRectMake((view.width - 150) * 0.5, CGRectGetMaxY(emptyLabel.frame) + 15, 150, 30)
        emptyButton.setBackgroundImage(UIImage(named: "btn.png"), forState: UIControlState.Normal)
        emptyButton.setTitle("去逛逛", forState: UIControlState.Normal)
        emptyButton.setTitleColor(UIColor.colorWithCustom(100, g: 100, b: 100), forState: UIControlState.Normal)
        emptyButton.addTarget(self, action: "leftNavigitonItemClick", forControlEvents: UIControlEvents.TouchUpInside)
        emptyButton.hidden = true
        view.addSubview(emptyButton)
    }
    
    // MARK:tableview  UI  headView
    func buildTableHeadView() {
    
        tableHeadView.backgroundColor = view.backgroundColor
        tableHeadView.frame = CGRectMake(0, 0, view.width, 250)
        
        //create 接收地址
        buildReceiptAddress()
        
        //闪电超市、红点等view
        buildMarketView()
        
        //收货时间、预定等
        buildSignTimeView()
        
        //收获备注等
        buildSignComments()
    }
    //MARK:headView辅助函数
    private func buildReceiptAddress() {
    
        receiptAdressView = ReceiptAddressView(frame: CGRectMake(0, 10, view.width, 70), modifyButtonClickCallBack: { () -> () in
            //收货地址修改单击回调
            
        })
        
        tableHeadView.addSubview(receiptAdressView!)
        
        if UserInfo.shareUserInfo.hasDefaultAdress() {
        
            receiptAdressView?.adress = UserInfo.shareUserInfo.defaultAdress()
        } else {
        
            weak var tempSelf = self
            AdressData.loadMyAdressData({ (data, error) -> Void in
                if error == nil {
                
                    if data!.data?.count > 0 {
                    
                        UserInfo.shareUserInfo.setAllAdress(data!.data!)
                        tempSelf!.receiptAdressView?.adress = UserInfo.shareUserInfo.defaultAdress()
                    }
                }
            })
        }
        
    }
    private func buildMarketView() {
    
        let marketView = ShopCartMarkerView(frame: CGRectMake(0,90,ScreenWidth,60))
        
        tableHeadView.addSubview(marketView)
    }
    private func buildSignTimeView() {
    
        let signTimeView = UIView(frame: CGRectMake(0, 150, view.width, ShopCartRowHeight))
        signTimeView.backgroundColor = UIColor.whiteColor()
        tableHeadView.addSubview(signTimeView)
        
        let tap = UITapGestureRecognizer(target: self, action: "modifySignTimeViewClick")
        tableHeadView.addGestureRecognizer(tap)
        
        let signTimeTitleLabel = UILabel()
        signTimeTitleLabel.text = "收货时间"
        signTimeTitleLabel.textColor = UIColor.blackColor()
        signTimeTitleLabel.font = UIFont.systemFontOfSize(15)
        signTimeTitleLabel.sizeToFit()
        signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, ShopCartRowHeight)
        signTimeView.addSubview(signTimeTitleLabel)
        
        signTimeLabel.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, view.width * 0.5, ShopCartRowHeight)
        signTimeLabel.textColor = UIColor.redColor()
        signTimeLabel.font = UIFont.systemFontOfSize(15)
        signTimeLabel.text = "闪电送达，及时达"
        signTimeView.addSubview(signTimeLabel)
        
        reserveLabel.text = "可预定"
        reserveLabel.backgroundColor = UIColor.whiteColor()
        reserveLabel.textColor = UIColor.redColor()
        reserveLabel.font = UIFont.systemFontOfSize(15)
        reserveLabel.frame = CGRectMake(view.width - 72, 0, 60, ShopCartRowHeight)
        signTimeView.addSubview(reserveLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRectMake(view.width - 15, (ShopCartRowHeight - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height)
        signTimeView.addSubview(arrowImageView)

    }
    func modifySignTimeViewClick() {
    
        print("修改收货时间")
    }
    private func buildSignComments() {
    
        commentsView.frame = CGRectMake(0,200,view.width,ShopCartRowHeight)
        tableHeadView.addSubview(commentsView)
    }
    
    // MARK:tableview
    func buildSupermarketTableView() {
    
        supermarketTableView.tableHeaderView = tableHeadView
        tableFooterView.frame = CGRectMake(0, ScreenHeight - 64 - 50, ScreenWidth, 50)
        view.addSubview(tableFooterView)
        
        tableFooterView.delegate = self
        supermarketTableView.dataSource = self
        supermarketTableView.delegate = self
        supermarketTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0)
        supermarketTableView.backgroundColor = view.backgroundColor
        view.addSubview(supermarketTableView)
        
    }
}

//MARK:协议代理方法实现
extension ShopCartViewController: ShopCartSupermarketTableFooterViewDelegate {

    func supermarketTableFooterDetermineButtonClick() {
        let orderPayVC = OrderPayWayViewController()
        navigationController?.pushViewController(orderPayVC, animated: true)
    }
}
//MARK:tableview的数据源和协议
extension ShopCartViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserShopCarTool.sharedUserShopCar.getShopCarproductsClassifNumber()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ShopCartCell.shopCarCell(tableView)
        cell.goods = UserShopCarTool.sharedUserShopCar.getShopCarProducts()[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        commentsView.textField.endEditing(true)
    }
}
