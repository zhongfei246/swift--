//
//  ProductsViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class ProductsViewController: AnimationViewController {

    
    private let headViewIdentifier   = "supermarketHeadView"
    private var lastOffsetY: CGFloat = 0
    private var isScrollDown         = false
    var productsTableView: LFBTableView?
    weak var delegate: ProductsViewControllerDelegate?
    var refreshUpPull:(() -> ())?
    
    private var goodsArr: [[Goods]]? {
        didSet {
            productsTableView?.reloadData()
        }
    }
    
    var supermarketData: Supermarket? {
        didSet {
            self.goodsArr = Supermarket.searchCategoryMatchProducts(supermarketData!.data!)
        }
    }
    
    var categortsSelectedIndexPath: NSIndexPath? {
        didSet {
            productsTableView?.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: categortsSelectedIndexPath!.row), animated: true, scrollPosition: .Top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)
        
        view = UIView(frame: CGRectMake(ScreenWidth * 0.25, 0, ScreenWidth * 0.75, ScreenHeight - NavgationH))
        buildProductsTableView()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    //MARK: -create UI tableView
    private func buildProductsTableView() {
    
        productsTableView = LFBTableView(frame: view.bounds, style: .Plain)
        productsTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        productsTableView?.backgroundColor = GloableBackgroundColor
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.registerClass(SupermarketHeadView.self, forHeaderFooterViewReuseIdentifier: headViewIdentifier)
        productsTableView?.tableFooterView = buildProductsTableViewTableFooterView()
        
        let headView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: "startRefreshUpPull")
        productsTableView?.mj_header = headView
        
        view.addSubview(productsTableView!)
    }
    private func buildProductsTableViewTableFooterView() -> UIView {
        let imageView = UIImageView(frame: CGRectMake(0, 0, productsTableView!.width, 70))
        imageView.contentMode = UIViewContentMode.Center
        imageView.image = UIImage(named: "v2_common_footer")
        return imageView
    }
    
    // MARK: - 上拉刷新
    func startRefreshUpPull() {
        if refreshUpPull != nil {
            refreshUpPull!()
        }
    }
    
    // MARK: - Action
    func shopCarBuyProductNumberDidChange() {
        productsTableView?.reloadData()
    }
}


//MARK: -代理方法定义
@objc protocol ProductsViewControllerDelegate: NSObjectProtocol {

    optional func didEndDisplayingHeaderView(section: Int)
    optional func willDisplayHeaderView(section: Int)
}

//MARK: -UITableViewDelegate, UITableViewDataSource
extension ProductsViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goodsArr?.count > 0 {
            return goodsArr![section].count ?? 0
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ProductCell.cellWithTableView(tableView)
        let goods = goodsArr![indexPath.section][indexPath.row]
        cell.goods = goods
        
        weak var tmpSelf = self
        cell.addProductClick = { (imageView) -> () in
            tmpSelf?.addProductsAnimation(imageView)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headViewIdentifier) as! SupermarketHeadView
        if supermarketData?.data?.categories?.count > 0 && supermarketData!.data!.categories![section].name != nil {
            headView.titleLabel.text = supermarketData!.data!.categories![section].name
        }
        
        return headView
    }
    
    //右边的展示商品的tableview向下滑动（就是向下翻，手指向上滑）
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if delegate != nil && delegate!.respondsToSelector("didEndDisplayingHeaderView:") && isScrollDown {
            delegate!.didEndDisplayingHeaderView!(section)
        }
    }
    //右边的展示商品的tableview向上滑动（就是向上翻，手指向下滑，返回）
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && delegate!.respondsToSelector("willDisplayHeaderView:") && !isScrollDown {
            delegate!.willDisplayHeaderView!(section)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let goods = goodsArr![indexPath.section][indexPath.row]
        let productDetailVC = ProductDetailViewController(goods: goods)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
// MARK: - UIScrollViewDelegate
extension ProductsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if animationLayers?.count > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.hidden = true
        }
        
        isScrollDown = lastOffsetY < scrollView.contentOffset.y
        lastOffsetY = scrollView.contentOffset.y
    }
    
}

