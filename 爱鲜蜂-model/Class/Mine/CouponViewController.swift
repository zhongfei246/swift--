//
//  CouponViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 10/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class CouponViewController: BaseViewController {

    private var couponView: bindingCouponView?
    private var couponTableView: LFBTableView?
    
    private var useCoupons: [Coupon] = [Coupon]()
    private var unUseCoupons: [Coupon] = [Coupon]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        setNavigationItem()
        
        buildBindingCouponView()
        
        buildCouponTableView()
        
        //导入数据
        loadCouponData()
    }

    //MARK: build UI
    func setNavigationItem() {
    
        navigationItem.title = "优惠券"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("使用规则", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: "rightItemClick")
    }
    func buildBindingCouponView() {
    
        couponView = bindingCouponView(frame: CGRectMake(0, 0, ScreenWidth, 50), bindingButtonClickBack: { (couponTextField) -> () in
            if couponTextField.text != nil && !(couponTextField.text!.isEmpty) {
            
                ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status:"请输入正确的优惠券")
            } else {
            
                let alertVC = UIAlertController(title: nil, message: "请输入优惠券码！", preferredStyle:UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (UIAlertAction alert) -> Void in
                   print("确定")
                })
                
                alertVC.addAction(alertAction)
                self.presentViewController(alertVC, animated: true, completion: nil)
            }
        })
        view.addSubview(couponView!)
    }
    private func buildCouponTableView() {
    
        couponTableView = LFBTableView(frame: CGRectMake(0, CGRectGetMaxY(couponView!.frame), ScreenWidth, ScreenHeight - couponView!.height - NavgationH), style: .Plain)
        couponTableView?.dataSource = self
        couponTableView?.delegate = self
        view.addSubview(couponTableView!)
    }
    
    //MARK: 导入数据
    private func loadCouponData() {
    
        weak var tempSelf = self
        CouponData.loadCouponData { (data, error) -> Void in
            if error != nil {
            
                return
            }
            if data?.data?.count > 0 {
            
                for obj in data!.data! {
                
                    switch obj.status {
                    
                    case 0: tempSelf!.useCoupons.append(obj)
                        break
                    default: tempSelf!.unUseCoupons.append(obj)
                        break
                    }
                }
            }
            tempSelf!.couponTableView?.reloadData()
        }
    }
    
    //MARK: Action
    func rightItemClick() {
    
        let couponRuleVC = CoupinRuleViewController()
        couponRuleVC.loadURLStr = CouponUserRuleURLString
        couponRuleVC.navTitle = "使用规则"
        navigationController?.pushViewController(couponRuleVC, animated: true)
    }

}

extension CouponViewController: UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == section {
                return useCoupons.count
            } else {
                return unUseCoupons.count
            }
        }
        
        if useCoupons.count > 0 {
            return useCoupons.count
        }
        
        if unUseCoupons.count > 0 {
            return unUseCoupons.count
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            return 2
        } else if useCoupons.count > 0 || unUseCoupons.count > 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CouponCell.cellWithTableView(tableView)
        var coupon: Coupon?
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == indexPath.section {
                coupon = useCoupons[indexPath.row]
            } else {
                coupon = unUseCoupons[indexPath.row]
            }
        } else if useCoupons.count > 0 {
            coupon = useCoupons[indexPath.row]
        } else if unUseCoupons.count > 0 {
            coupon = unUseCoupons[indexPath.row]
        }
        
        cell.coupon = coupon!
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if unUseCoupons.count > 0 && useCoupons.count > 0 && 0 == section {
            return 10
        }
        
        return 0
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if unUseCoupons.count > 0 && useCoupons.count > 0 {
            if 0 == section {
                let footView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 10))
                footView.backgroundColor = UIColor.clearColor()
                let lineView = UIView(frame: CGRectMake(CouponViewControllerMargin, 4.5, ScreenWidth - 2 * CouponViewControllerMargin, 1))
                lineView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
                footView.addSubview(lineView)
                return footView
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
