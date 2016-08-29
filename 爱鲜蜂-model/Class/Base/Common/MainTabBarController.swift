//
//  MainTabBarController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 4/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class MainTabBarController: AnimationTabBarController,UITabBarControllerDelegate {

    private var fristLoadMainTabBarController: Bool = true
    private var adImageView: UIImageView?
    var adImage: UIImage?{
        
        didSet {
            
            weak var tmpSelf = self
            adImageView = UIImageView(frame: ScreenBounds)
            adImageView!.image = adImage!
            self.view.addSubview(adImageView!)
            
            UIImageView.animateWithDuration(2.0, animations: { () -> Void in
                tmpSelf!.adImageView!.transform = CGAffineTransformMakeScale(1.2,1.2)
                tmpSelf!.adImageView!.alpha = 0
                }) { (finsh) -> Void in
                   tmpSelf!.adImageView!.removeFromSuperview()
                    tmpSelf!.adImageView = nil
            }
        }
    }
//    MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        //建立tabbar
        buildMainTabBarChildViewController()
        
    }
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if fristLoadMainTabBarController { //第一次导入MainTabBarController的时候创建tabBar（tabbar自定义）
        
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            fristLoadMainTabBarController = false
        }
        
    }
    
//    MARK: - Method
    private func buildMainTabBarChildViewController() {
    
       //这里添加控制器，需要创建
       tabBarControllerAddChildViewController(HomeViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r", tag: 0)
       tabBarControllerAddChildViewController(SupermarketViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r", tag: 1)
        
        tabBarControllerAddChildViewController(ShopCartViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart", tag: 2)
        tabBarControllerAddChildViewController(MineViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r", tag: 3)
    }
    
    private func tabBarControllerAddChildViewController(childView: UIViewController, title: String,imageName: String,selectedImageName: String,tag: Int) {
    
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.tag = tag
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationViewController(rootViewController:childView)
        addChildViewController(navigationVC)
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        let childArr = tabBarController.childViewControllers as NSArray
        let index = childArr.indexOfObject(viewController)
        
        if index == 2 {
        
            return false
        }
        return true
    }
    
}
