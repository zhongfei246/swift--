//
//  AppDelegate.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 25/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var adViewController: ADViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSThread.sleepForTimeInterval(1.0)
        
        //友盟初始化
        setUM()
        
        //添加广告页通知
        setAppSubject()
        
        //添加通知
        addNotification()
        
        //建立窗口
        buildKeyWindow()
        
        return true
    }

    //MARK: -自定义函数
    
    //MARK: -释放通知中心的Observer
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: -友盟相关
    func setUM() {
    
        UMSocialData.setAppKey("569f662be0f55a0efa0001cc")
        UMSocialWechatHandler.setWXAppId("wxb81a61739edd3054", appSecret: "c62eba630d950ff107e62fe08391d19d", url: "https://github.com/ZhongTaoTian")
        UMSocialQQHandler.setQQWithAppId("1105057589", appKey: "Zsc4rA9VaOjexv8z", url: "http://www.jianshu.com/users/5fe7513c7a57/latest_articles")
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("1939108327", redirectURL: "http://sns.whalecloud.com/sina2/callback")
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToWechatTimeline])
    }
    //MARK: -tabBar设置相关(全局设置,私有方法)
    private func setAppSubject() {
    
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.whiteColor()
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.translucent = false
        
    }
    
    //MARK: -添加通知
    func addNotification() {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showMainTabbarControllerSucess:", name: ADImageLoadSecussed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabbarControllerFale", name: ADimageLoadFail, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainTabBarController", name: GuideViewControllerDidFinish, object: nil)
    }
    
    //MARK: - NSNotification相关的func（广告导入成功，在这个通知中建立tabBar）
    func showMainTabbarControllerSucess(noti: NSNotification) {
    
        let adImage = noti.object as! UIImage
        let mainTabBar = MainTabBarController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    //MARK: -AD图片导入失败
    func showMainTabbarControllerFale() {
    
        window!.rootViewController = MainTabBarController()
    }
    
    func showMainTabBarController() {
        window!.rootViewController = MainTabBarController()
    }
    
    //MARK: -建立window
    private func buildKeyWindow() {
    
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()
        
        let isFirstOpen = NSUserDefaults.standardUserDefaults().objectForKey("isFirstOpenApp")
        
        if isFirstOpen == nil {
        
            window?.rootViewController = GuideViewController()
            NSUserDefaults.standardUserDefaults().setObject("isFirstOpenApp", forKey: "isFirstOpenApp")
        } else {
        
            loadADRootViewController()
        }
        
    }
    //MARK: -创建广告页控制器
    func loadADRootViewController() {
    
        adViewController = ADViewController()
        
        weak var tempSelf = self
        MainAD.loadADData { (data, error) -> Void in
        
            if data?.data?.img_name != nil {
            
                tempSelf!.adViewController!.imageName = data!.data!.img_name
                tempSelf!.window?.rootViewController = self.adViewController
            }
        }
 
    }
    
    //MARK: -系统生命周期函数
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

