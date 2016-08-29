//
//  Theme.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 25/4/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import Foundation

//mark -全局常用属性
public let NavgationH: CGFloat = 64
public let ScreenWidth:CGFloat = UIScreen.mainScreen().bounds.width
public let ScreenHeight:CGFloat = UIScreen.mainScreen().bounds.height
public let ScreenBounds:CGRect = UIScreen.mainScreen().bounds
public let ShopCarRedDotAnimationDurtion:NSTimeInterval = 0.2
public let LFBNavigationBarWhiteBackgroundColor = UIColor.colorWithCustom(249, g: 250, b: 253)

//mark - Home 属性
public let HotViewMargin: CGFloat = 10
public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFontOfSize(14.0)
public let HomeCollectionCellAnimationDuration: NSTimeInterval = 1.0

// MARK: - 通知
/// 首页headView高度改变
public let HomeTableHeadViewHeightDidChange = "HomeTableHeadViewHeightDidChange"
/// 首页商品库存不足
public let HomeGoodsInventoryProblem = "HomeGoodsInventoryProblem"

// MARK: - AuthorURL
public let GitHubURLString: String = "https://github.com/ZhongTaoTian"
public let SinaWeiBoURLString: String = "http://weibo.com/tianzhongtao"
public let BlogURLString: String = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"
public let ZFBlogURLString: String = "https://github.com/zhongfei246"

//mark - 广告也通知
public let ADImageLoadSecussed = "ADImageLoadSecussed"
public let ADimageLoadFail = "ADImageLoadFail"

//广告也导入结束
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"

// MARK: - 购物车管理工具通知
public let LFBShopCarDidRemoveProductNSNotification = "LFBShopCarDidRemoveProductNSNotification"
/// 购买商品数量发生改变
public let LFBShopCarBuyProductNumberDidChangeNotification = "LFBShopCarBuyProductNumberDidChangeNotification"
/// 购物车商品价格发送改变
public let LFBShopCarBuyPriceDidChangeNotification = "LFBShopCarBuyPriceDidChangeNotification"
// MARK: - 购物车ViewController
public let ShopCartRowHeight: CGFloat = 50

// MARK: - Mine属性
public let CouponViewControllerMargin: CGFloat = 20

//mark -常用颜色
public let GloableBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
public let NavgationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49)
public let TextGreyColor = UIColor.colorWithCustom(130, g: 130, b: 130)
public let TextBlackColor = UIColor.colorWithCustom(50, g: 50, b: 50)

// MARK: - 搜索ViewController
public let LFBSearchViewControllerHistorySearchArray = "LFBSearchViewControllerHistorySearchArray"

// MARK: Cache路径
public let LFBCachePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!

// MARK: - HTMLURL
///优惠劵使用规则
public let CouponUserRuleURLString = "http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D"


