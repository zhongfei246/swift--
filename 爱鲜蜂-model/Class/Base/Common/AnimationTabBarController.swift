//
//  AnimationTabBarController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 26/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit


class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(icon: UIImageView, textLabel: UILabel) {
        playBounceAnnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    //重写tabBar取消选中的函数
    override func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
        
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }
    
    //重写tabBar选中的函数
    override func selectedState(icon: UIImageView, textLabel: UILabel) {
         textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
        
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    
    func playBounceAnnimation(icon : UIImageView) {
    
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0,1.4,0.9,1.15,0.95,1.02,1.0]
        bounceAnimation.duration = NSTimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        /**
        *  1 const kCAAnimationLinear//线性，默认
           2 const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
           3 const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
           4 const kCAAnimationCubic//平均，同上
           5 const kCAAnimationCubicPaced//平均，同上
        
        //动画的暂停与播放
         -(void)pauseLayer:(CALayer*)layer
         {
             CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
             layer.speed = 0.0;
             layer.timeOffset = pausedTime;
         }
        
         -(void)resumeLayer:(CALayer*)layer
         {
             CFTimeInterval pausedTime = [layer timeOffset];
             layer.speed = 1.0;
             layer.timeOffset = 0.0;
             layer.beginTime = 0.0;
             CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
             layer.beginTime = timeSincePause;
         }
        
        */
        
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        if let iconImage = icon.image {
        
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
}


protocol RAMItemAnimationProtocol {

    //执行动画函数
    func playAnimation(icon : UIImageView, textLabel : UILabel)
    //选中动画函数
    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor)
    //选中状态
    func selectedState(icon : UIImageView, textLabel : UILabel)
}

class RAMItemAnimation: NSObject, RAMItemAnimationProtocol {
    
    var duration : CGFloat = 0.6
    var textSelectedColor: UIColor = UIColor.grayColor()
    var iconSelectedColor: UIColor?
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {
        
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        
    }
}



class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation?
    
    var textColor = UIColor.grayColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel) {
    
        guard let animation = animation else {
        
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(icon: UIImageView,textLabel: UILabel) {
    
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectState(icon: UIImageView,textLabel: UILabel) {
    
        animation?.selectedState(icon, textLabel: textLabel)
    }
    
}

class AnimationTabBarController: UITabBarController {

    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]
    var shopCarIcon: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "searchViewControllerDeinit", name: "LFBSearchViewControllerDeinit", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func searchViewControllerDeinit() {
    
        if shopCarIcon != nil {
        
            let redDotView = ShopCarRedDotView.sharedRedDotView
            redDotView.frame = CGRectMake(21+1, -3, 15, 15)
            shopCarIcon?.addSubview(redDotView)
        }
    }
    
    //创建自定义的tabBar内部单个itemView
    func createViewContainer(index: Int) -> UIView {
    
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.bounds.size.height
        
        let viewContainer = UIView(frame: CGRectMake(viewWidth * CGFloat(index),0,viewWidth,viewHeight))
        
        viewContainer.backgroundColor = UIColor.clearColor()
        viewContainer.userInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag=index
        
        let  tap = UITapGestureRecognizer(target: self, action: "tabBarClick:")
        viewContainer.addGestureRecognizer(tap)
        
        return viewContainer
    }
    
    //创建tabBar的itemViews(返回字典)
    func createViewContainers() -> [String: UIView] {
    
        var containerDict = [String: UIView]()
        
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem] else {
        
            return containerDict
        }
        
        for index in 0..<customItems.count {
        
            let viewController = createViewContainer(index)
            containerDict["container\(index)"] = viewController
        }
        
        return containerDict
    }
    
    func createCustomIcons(containers : [String: UIView]) {
    
        if let items = tabBar.items {
        
            for (index, item) in items.enumerate(){
            
                assert(item.image != nil, "add image icon in uitabbatItem")
                
                guard let container = containers["container\(index)"] else {
                
                    print("no container given")
                    continue
                }
                
                container.tag = index
                
                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW)*0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRectMake(imageX, imageY, imageW, imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clearColor()
                
                //text
                let textLabel = UILabel()
                textLabel.frame = CGRectMake(0, 32, ScreenWidth / CGFloat(items.count), 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.textColor = UIColor.grayColor()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items {
                
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                
                if 2 == index {
                
                    let redDotView = ShopCarRedDotView.sharedRedDotView
                    redDotView.frame = CGRectMake(imageH + 1, -3, 15, 15)
                    icon.addSubview(redDotView)
                    shopCarIcon = icon
                }
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                
                    selectedIndex = 0
                    selectItem(0)
                }
                
            }
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        setSelectIndex(from: selectedIndex, to: item.tag)
    }
    
    func selectItem(Index: Int) {
    
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[Index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[Index])!
        items[Index].selectState(selectIcon, textLabel: iconsView[Index].textLabel)
    }

    //bug一处：点击tabBar时，当点击购物车的时候弹出一个界面，再点击购物车界面上的返回后，再点击其他tabBar选项，则之前选中的item还是图片选择状态，经查找，是selectedIndex在弹出购物车界面和这个界面dismiss后，selectedIndex变为2了，实际应该还是弹出购物车之前选中的selectedIndex，暂未解决！
    
    //解决方案：之所以能造成selectedIndex改变是因为index等于2时执行了tabBar的shouldSelectViewController代理函数，确切的说是该函数执行后返回了true（等于2时应该return false，不让tabBar选中购物车控制器所在的item，从而从from来的控制器直接present购物车控制器），然而我在检查代码时检查到这个函数没有检查出来；
    //造成此函数在选中购物车item返回true的原因是：获得index时参数viewController我写成了ViewController，造成找不到正确的index（2），所以这个if判断（shouldSelectViewController代理函数中的）进不去进而返回了true。（之所以能造成我把viewController写成ViewController，是因为工程初建时有个ViewController.swift，没有用到我也没有删除，造成写代码时使用自动提示时没有看清直接敲回车错选成了ViewController类名（应该是shouldSelectViewController函数的形参：viewController），swift没有头文件，所有的文件都默认能引用）。害我苦逼的找了好久的bug。。。。。
    
    //总结：shouldSelectViewController返回true，selectedIndex才能改变（进而可进行相应的逻辑）
    
    //选中item的辅助函数(动画的执行)
    func setSelectIndex(from from: Int,to: Int) {
    
        if to == 2 {
        
            let vc = childViewControllers[selectedIndex]
            let shopCar = ShopCartViewController()
            let nav = BaseNavigationViewController(rootViewController: shopCar)
            vc.presentViewController(nav, animated: true, completion: nil)
            
            return
        }
        
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel)
    }
    
}
