//
//  MyAdressViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 17/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class MyAdressViewController: BaseViewController {
    
    private var addAdressButton: UIButton?
    private var nullImageView = UIView()
    
    var selectedAdressCallback:((adress: Adress) -> ())?
    var isSelectVC = false
    var adressTableview: LFBTableView?
    var adresses: [Adress]? {
    
        didSet {
        
            if adresses?.count == 0 {
            
                nullImageView.hidden = false
                adressTableview?.hidden = true
            } else {
            
                nullImageView.hidden = true
                adressTableview?.hidden = false
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置Navigation Item
        buildNavigationItem()
        
        //创建tableview
        buildAdressTableView()
        
        //空地址view
        buildNullImageView()
        
        //导入数据
        loadAdressData()
        
        //底部的地址说明栏
        buildBottomAddAdressButtom()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(selectedAdress: ((adress:Adress) -> ())) {
    
        self.init(nibName:nil, bundle: nil)
        selectedAdressCallback = selectedAdress
    }
    
    //buildUI
    private func buildNavigationItem() {
    
        navigationItem.title = "我的收货地址"
    }
    //tableview
    private func buildAdressTableView() {
    
        adressTableview = LFBTableView(frame: view.bounds, style: .Plain)
        adressTableview?.frame.origin.y += 10
        adressTableview?.backgroundColor = UIColor.clearColor()
        adressTableview?.rowHeight = 80
        adressTableview?.dataSource = self
        adressTableview?.delegate = self
        view.addSubview(adressTableview!)
    }
    //空地址view
    private func buildNullImageView() {
     
        nullImageView.backgroundColor = UIColor.clearColor()
        nullImageView.frame = CGRectMake(0, 0, 200, 200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: UIImage(named: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRectMake(0,CGRectGetMaxY(imageView.frame)+10,200,20))
        label.text = "你还没有地址哦~"
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(14)
        nullImageView.addSubview(label)
    }
    //导入地址数据
    private func loadAdressData() {
    
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
            
                if data?.data?.count > 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableview?.hidden = false
                    tmpSelf!.adressTableview?.reloadData()
                    tmpSelf!.nullImageView.hidden = true
                    UserInfo.shareUserInfo.setAllAdress(data!.data!)
                } else {
                    tmpSelf!.adressTableview?.hidden = true
                    tmpSelf!.nullImageView.hidden = false
                    UserInfo.shareUserInfo.cleanAllAdress()
                }
            }
        }
    }
    //创建底部地址栏
    private func buildBottomAddAdressButtom() {
    
        //大的背景view
        let bottomView = UIView(frame: CGRectMake(0,ScreenHeight - 60 - 64,ScreenWidth,60))
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        
        addAdressButton = UIButton(frame: CGRectMake(ScreenWidth * 0.15, 12, ScreenWidth * 0.7, 60 - 12 * 2))
        addAdressButton?.setTitle("+ 新增地址", forState: .Normal)
        addAdressButton?.backgroundColor = UIColor.redColor()
        addAdressButton?.layer.cornerRadius = 8
        addAdressButton?.layer.masksToBounds = true
        addAdressButton?.addTarget(self, action: "addAdressButtonClick", forControlEvents: .TouchUpInside)
        addAdressButton?.titleLabel?.font = UIFont.systemFontOfSize(15)
        addAdressButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        bottomView.addSubview(addAdressButton!)
    }
    //辅助函数--添加收货地址
    func addAdressButtonClick() {
    
        let editVC = EditAdressViewController()
        editVC.topVC = self
        editVC.vcType = EditAdressViewControllerType.Add
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}

// MARK: - UITableView数据源方法和代理方法
extension MyAdressViewController:UITableViewDataSource,UITableViewDelegate {

    //每个section的rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresses?.count ?? 0
    }
    //cell函数
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        weak var temoSelf = self
        let cell = AdressCell.adressCell(tableView, indexPath: indexPath) { (cellIndexPathRow) -> Void in
            
            print("cellIndexPathRow  \(cellIndexPathRow)")
            
           let editAderssVC = EditAdressViewController()
            editAderssVC.topVC = temoSelf
            editAderssVC.vcType = EditAdressViewControllerType.Edit
            editAderssVC.currentAdressRow = indexPath.row
            temoSelf!.navigationController?.pushViewController(editAderssVC, animated: true)
        }
        
        cell.adress = adresses![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isSelectVC {
        
            if selectedAdressCallback != nil {
            
            selectedAdressCallback!(adress: adresses![indexPath.row])
            navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
}

