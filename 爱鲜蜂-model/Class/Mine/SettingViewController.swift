//
//  SettingViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 4/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    private let subViewHeight: CGFloat = 50
    private var aboutMeView: UIView!
    private var cleanCacheView: UIView!
    private var logoutView:UIView!
    private var cacheNumberLabel:UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print(self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpUI()
        
        //关于view
        buildAboutMeView()
        
        //清除缓存view
        buildCleanCacheView()
        
        buildLogoutView()
        
    }

    //MARK: build UI
    private func setUpUI() {
    
        navigationItem.title = "设置"
    }
    private func buildAboutMeView() {
    
        aboutMeView = UIView(frame: CGRectMake(0,10,ScreenWidth,subViewHeight))
        aboutMeView.backgroundColor = UIColor.whiteColor()
        view.addSubview(aboutMeView)
        
        let tap = UITapGestureRecognizer(target: self, action: "aboutMeViewClick");
        aboutMeView.addGestureRecognizer(tap)
    
        let aboutLabel = UILabel(frame: CGRectMake(20,0,250,subViewHeight))
        aboutLabel.text = "zhongfei And 原创作者：小熊"
        aboutLabel.font = UIFont.systemFontOfSize(16.0)
        aboutMeView.addSubview(aboutLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRectMake(ScreenWidth - 20, (subViewHeight - 10) * 0.5, 5, 10)
        aboutMeView.addSubview(arrowImageView)
    }
    private func buildCleanCacheView() {
    
        cleanCacheView = UIView(frame: CGRectMake(0,subViewHeight + 10,ScreenWidth,subViewHeight))
        cleanCacheView.backgroundColor = UIColor.whiteColor()
        view.addSubview(cleanCacheView)
        
        //内部子控件
        let cleanCacheLabel = UILabel(frame: CGRectMake(20,0,200,subViewHeight))
        cleanCacheLabel.text = "清理缓存"
        cleanCacheLabel.font = UIFont.systemFontOfSize(16)
        cleanCacheView.addSubview(cleanCacheLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "cleanCacheViewClick")
        cleanCacheView.addGestureRecognizer(tap)
       
        cacheNumberLabel = UILabel(frame: CGRectMake(150, 0, ScreenWidth - 165, subViewHeight))
        cacheNumberLabel.textAlignment = .Right
        cacheNumberLabel.textColor = UIColor.colorWithCustom(180, g: 180, b: 180)
        cacheNumberLabel.text = String().stringByAppendingFormat("%.2fM",FileTool.folderSize(LFBCachePath)).cleanDecimalPointZear()
        cleanCacheView.addSubview(cacheNumberLabel)
        
        let lineView = UIView(frame: CGRectMake(10,-0.5,ScreenWidth - 10,0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.08
        cleanCacheView.addSubview(lineView)
    }
    private func buildLogoutView() {
    
        logoutView = UIView(frame: CGRectMake(0,CGRectGetMaxY(cleanCacheView.frame) + 20,ScreenHeight,subViewHeight))
        logoutView.backgroundColor = UIColor.whiteColor()
        view.addSubview(logoutView)
        
        let logoutLabel = UILabel(frame: CGRectMake(0,0,ScreenWidth,subViewHeight))
        logoutLabel.text = "退出当前账号"
        logoutLabel.textColor = UIColor.colorWithCustom(60, g: 60, b: 60)
        logoutLabel.userInteractionEnabled=true
        logoutLabel.textAlignment = .Center
        logoutView.addSubview(logoutLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "logoutViewClick")
        logoutLabel.addGestureRecognizer(tap)
    }
    
    // -Action
    func aboutMeViewClick() {
    
        let aboutVC = aboutAuthorViewController()
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    func cleanCacheViewClick() {
    
        weak var tempSelf = self
        ProgressHUDManager.show()
        FileTool.cleanFolder(LFBCachePath) { () -> () in
            tempSelf!.cacheNumberLabel.text = "0M"
            ProgressHUDManager.dismiss()
        }
    }
    func logoutViewClick() {
    
        ProgressHUDManager.showWithStatus("退出登录点击")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            ProgressHUDManager.dismiss()
        }
    }
    
}
