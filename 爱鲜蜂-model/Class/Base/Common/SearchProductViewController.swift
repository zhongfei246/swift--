//
//  SearchProductViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 17/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class SearchProductViewController: AnimationViewController {

    private let contentScollView = UIScrollView(frame: ScreenBounds)
    private let searchBar = UISearchBar()
    private let clearHistoryButton: UIButton = UIButton()
    private var historySearchView: SearchView?
    private var goodses: [Goods]?
    private var hotSearchView: SearchView?
    private var searchCollectionView: LFBCollectionView?
    private var collectionHeadView: NotSearchProductsView?
    private var yellowShopCar: YellowShopCarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建scrollView
        buildContentScrollView()
        
        //create searchBar
        buildSearchBar()
        
        //清空历史按钮
        buildClearHistorySearchButton()
        
        //导入热门搜索对应的数据
        loadHotSearchButtonData()
        
        //导入历史搜索对应按钮的数据
        loadHistorySearchButtonData()
        
        //创建collectionView
        buildSearchCollectionView()
        
        //购物车
        buildYellowShopCar()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        
        if searchCollectionView != nil && goodses?.count > 0 {
        
           searchCollectionView!.reloadData()
        }
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
    }

    //create UI
    private func buildContentScrollView() {
    
        contentScollView.backgroundColor = view.backgroundColor
        contentScollView.alwaysBounceVertical = true
        contentScollView.delegate = self
        view.addSubview(contentScollView)
    }
    //searchBar
    private func buildSearchBar() {
    
        (navigationController as! BaseNavigationViewController).backBtn.frame = CGRectMake(0, 0, 10, 40)
        
        let tempView = UIView(frame: CGRectMake(0,0,ScreenWidth * 0.8,30))
        tempView.backgroundColor = UIColor.whiteColor()
        tempView.layer.masksToBounds = true
        tempView.layer.cornerRadius = 6
        tempView.layer.borderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1).CGColor
        tempView.layer.borderWidth = 0.2
        let image = UIImage.createImageFromView(tempView)
        
        searchBar.frame = CGRectMake(0, 0, ScreenWidth * 0.9, 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.keyboardType = .Default
        searchBar.setSearchFieldBackgroundImage(image, forState: .Normal)// 设置搜索框中文本框的背景
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        //设置返回
        let navVC = navigationController as! BaseNavigationViewController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn?.addTarget(self, action: "leftButtonClcik", forControlEvents: .TouchUpInside)
        navVC.isAnimation = false
        
    }
    //辅助函数
    func leftButtonClcik() {
    
        searchBar.endEditing(false)
    }
    //清空历史按钮
    private func buildClearHistorySearchButton() {
    
        clearHistoryButton.setTitle("清 空 历 史", forState: .Normal)
        clearHistoryButton.backgroundColor = view.backgroundColor
        clearHistoryButton.layer.cornerRadius = 5
        clearHistoryButton.layer.masksToBounds = true
        clearHistoryButton.setTitleColor(UIColor.colorWithCustom(163, g: 163, b: 163), forState: .Normal)
        clearHistoryButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        clearHistoryButton.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
        clearHistoryButton.layer.borderWidth = 0.5
        clearHistoryButton.hidden = true
        clearHistoryButton.addTarget(self, action: "cleanSearchHistorySearch", forControlEvents: .TouchUpInside)
        
        contentScollView.addSubview(clearHistoryButton)
    }
    //清空按钮点击函数
    func cleanSearchHistorySearch() {
    
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        historySearch?.removeAll()
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
        
        updateCleanHistoryButton(true)
    }
    //导入历史搜索数据函数
    func loadHistorySearchButtonData() {
    
        if historySearchView != nil {
         
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        
        weak var tempSelf = self
        let array = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as! [String]
        if array.count > 0 {
        
            historySearchView = SearchView(frame: CGRectMake(10, CGRectGetMaxY(hotSearchView!.frame) + 20, ScreenWidth - 20, 0), searchTitleText: "历史记录", searchButtonTitleTexts: array, searchButtonClickCallback: { (sender) -> () in
            
                tempSelf!.searchBar.text = sender.titleForState(UIControlState.Normal)
                tempSelf!.loadProductsWithKeyword(sender.titleForState(UIControlState.Normal)!)
            })
            historySearchView!.frame.size.height = historySearchView!.searchHeight
            
            contentScollView.addSubview(historySearchView!)
            updateCleanHistoryButton(false)
        }
    }
    //设置清除历史按钮的隐藏与否
    private func updateCleanHistoryButton(hidden: Bool) {
    
        if historySearchView != nil {
        
            clearHistoryButton.frame = CGRectMake(0.1 * ScreenWidth, CGRectGetMaxY(historySearchView!.frame)+20, ScreenWidth * 0.8, 40)
        }
        clearHistoryButton.hidden = hidden
    }
    
    func loadProductsWithKeyword(keyword: String?) {
    
        if keyword == nil || keyword?.characters.count == 0 {
        
            return
        }
        
        ProgressHUDManager.setBackgroundColor(UIColor.whiteColor())
        ProgressHUDManager.showWithStatus("正在全力加载")
        
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double (NSEC_PER_SEC)))
        dispatch_after( time, dispatch_get_main_queue()) { () -> Void in
            SearchProducts.loadSearchData({ (data, error) -> Void in
                if data?.data?.count > 0 {
                
                    tmpSelf?.goodses = data!.data!
                    tmpSelf?.searchCollectionView?.hidden = false
                    tmpSelf?.yellowShopCar?.hidden = false
                    tmpSelf?.searchCollectionView?.reloadData()
                    tmpSelf?.collectionHeadView?.setSearchProductLabelText(keyword!)
                    tmpSelf?.searchCollectionView?.setContentOffset(CGPointMake(0, -80), animated: false)
                    ProgressHUDManager.dismiss()
                }
            })
        }
    }
    //导入热门数据
    private func loadHotSearchButtonData() {
    
        var array: [String]?
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        if historySearch == nil {
        
            historySearch = [String]()
            NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        }
        weak var tempSelf = self
        let pathStr = NSBundle.mainBundle().pathForResource("SearchProduct", ofType: nil)
        let data = NSData(contentsOfFile: pathStr!)
        if data != nil {
        
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            array = (dict.objectForKey("data")! as! NSDictionary).objectForKey("hotquery") as? [String]
            if array?.count > 0 {
            
                hotSearchView = SearchView(frame: CGRectMake(10, 20, ScreenWidth - 20, 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array!) { (sender) -> () in
                  
                    let str = sender.titleForState(UIControlState.Normal)
                    tempSelf!.writeHistorySearchToUserDefault(str!)
                    tempSelf!.searchBar.text = sender.titleForState(.Normal)
                    tempSelf!.loadProductsWithKeyword(sender.titleForState(.Normal))
                    
                }
                hotSearchView!.frame.size.height = hotSearchView!.searchHeight
                    
                contentScollView.addSubview(hotSearchView!)
            
            }
        }
        
    }
    //辅助函数
    // MARK: - Private Method
    private func writeHistorySearchToUserDefault(str: String) {
        var historySearch = NSUserDefaults.standardUserDefaults().objectForKey(LFBSearchViewControllerHistorySearchArray) as? [String]
        for text in historySearch! {
            if text == str {
                return
            }
        }
        historySearch!.append(str)
        NSUserDefaults.standardUserDefaults().setObject(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
    }
    
    //collectionView创建
    private func buildSearchCollectionView() {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin)
        
        searchCollectionView = LFBCollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64), collectionViewLayout: layout)
        searchCollectionView!.delegate = self
        searchCollectionView!.dataSource = self
        searchCollectionView!.backgroundColor = GloableBackgroundColor
        searchCollectionView!.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        searchCollectionView?.hidden = true
        collectionHeadView = NotSearchProductsView(frame: CGRectMake(0, -80, ScreenWidth, 80))
        searchCollectionView?.addSubview(collectionHeadView!)
        searchCollectionView?.contentInset = UIEdgeInsetsMake(80, 0, 30, 0)
        searchCollectionView?.registerClass(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        view.addSubview(searchCollectionView!)
    }
    //购物车
    private func buildYellowShopCar() {
    
        weak var tmpSelf = self
        
        yellowShopCar = YellowShopCarView(frame: CGRectMake(ScreenWidth - 70, ScreenHeight - 70 - NavgationH, 61, 61), shopViewClick: { () -> () in
            let shopCarVC = ShopCartViewController()
            let nav = BaseNavigationViewController(rootViewController: shopCarVC)
            tmpSelf!.presentViewController(nav, animated: true, completion: nil)
        })
        yellowShopCar?.hidden = true
        view.addSubview(yellowShopCar!)
    }
}

//MARK: 协议实现

//searchBar和scrollView
extension SearchProductViewController: UISearchBarDelegate,UIScrollViewDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count > 0 {
        
            writeHistorySearchToUserDefault(searchBar.text!)
            
            loadProductsWithKeyword(searchBar.text!)
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.endEditing(false)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
        
            searchCollectionView?.hidden = true
            yellowShopCar?.hidden = true
        }
    }
}

//CollectionView
extension SearchProductViewController: UICollectionViewDataSource,UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodses?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCell
        cell.goods = goodses![indexPath.row]
        weak var tmpSelf = self
        cell.addButtonClick = ({ (imageView) -> () in
            tmpSelf?.addProductsToBigShopCarAnimation(imageView)
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemSize = CGSizeMake((ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, 250)
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if goodses?.count <= 0 || goodses == nil {
            return CGSizeZero
        }
        
        return CGSizeMake(ScreenWidth, 30)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HomeCollectionFooterView
            
            footerView.setFooterTitle("无更多商品", textColor: UIColor.colorWithCustom(50, g: 50, b: 50))
            
            return footerView
            
        } else {
            return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = ProductDetailViewController(goods: goodses![indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

