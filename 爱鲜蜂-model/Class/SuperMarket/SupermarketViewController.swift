//
//  SupermarketViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 17/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//  实现思路：左侧为一个tableview，宽度为0.25*宽，右边是个VC的view，这个vc的view是我们自己定制化的，覆盖系统的self.view并且宽度等于0.75*宽。左边tableview点击cell时通过属性set方法传递给右边控制器信息，右边单击cell通过代理传递信息给SupermarketViewController。

import UIKit

class SupermarketViewController: SelectedAdressViewController {

    private var supermarketData: Supermarket?
    private var categoryTableView: LFBTableView!
    private var productsVC: ProductsViewController!
    
    //flag
    private var categoryTableViewIsLoadFinsh = false
    private var productTableViewIsLoadFinish  = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
        navigationController?.navigationBar.barTintColor = NavgationYellowColor
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加通知
        addNotification()
        
        //显示进程
        showProgressHUD()
        
        //tableView
        buildCategoryTableView()
        
        //创建子VC
        buildProductsViewController()
        
        //导入数据
        loadSupermarketData()
        
    }
    
    //MARK: -Build UI(添加通知)
    func addNotification() {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)
    }
    func shopCarBuyProductNumberDidChange() {
    
        if productsVC.productsTableView != nil {
        
            productsVC.productsTableView!.reloadData()
        }
    }
    
    //MARK: -进程progress
    private func showProgressHUD() {
    
        ProgressHUDManager.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
        view.backgroundColor = UIColor.whiteColor()
        
        if !ProgressHUDManager.isVisible() {
        
            ProgressHUDManager.showWithStatus("正在加载中")
        }
    }

    //MARK: -tableView  左边的产品分类的列表
    private func buildCategoryTableView() {
    
        categoryTableView = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth * 0.25, ScreenHeight), style: .Plain)
        categoryTableView.backgroundColor = GloableBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavgationH, right: 0)
        categoryTableView.hidden = true;
        view.addSubview(categoryTableView)
    }
    
    //MARK: -productVC创建  右边的那个展示产品信息的
    private func buildProductsViewController() {
    
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.hidden = true
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        productsVC.refreshUpPull = {
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.2 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                Supermarket.loadSupermarketData { (data, error) -> Void in
                    if error == nil {
                        tmpSelf!.supermarketData = data
                        tmpSelf!.productsVC.supermarketData = data
                        tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        tmpSelf!.categoryTableView.reloadData()
                        tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                    }
                }
            })
        }
    }
    
    //导入数据
    private func loadSupermarketData() {
    
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            weak var tmpSelf = self
            Supermarket.loadSupermarketData({ (data, error) -> Void in
                if error == nil {
                
                    tmpSelf!.supermarketData = data
                    tmpSelf!.categoryTableView.reloadData()
                    tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Bottom)
                    tmpSelf!.productsVC.supermarketData = data
                    tmpSelf!.categoryTableViewIsLoadFinsh = true
                    tmpSelf!.productTableViewIsLoadFinish = true
                    if tmpSelf!.categoryTableViewIsLoadFinsh && tmpSelf!.productTableViewIsLoadFinish {
                        tmpSelf!.categoryTableView.hidden = false
                        tmpSelf!.productsVC.productsTableView!.hidden = false
                        tmpSelf!.productsVC.view.hidden = false
                        tmpSelf!.categoryTableView.hidden = false
                        ProgressHUDManager.dismiss()
                        tmpSelf!.view.backgroundColor = GloableBackgroundColor
                    }
                }
            })
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
        }
    }
}

// MARK: - SupermarketViewController
extension SupermarketViewController: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section + 1, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
}
