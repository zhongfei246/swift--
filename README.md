# swift--
这是一套swift写的仿爱鲜蜂app的代码（仿自昵称为维尼的小熊），代码中有汉语注释，清晰明了。

下面是一些图文介绍：
  1.首页


   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/firstpage.png)
   
   页面介绍：上面是一个scrollView的轮播，下面是一些按钮（一屏4个，有多少根据网络请求而定），这些部分是作为collectionView的headerView展示，collectionView部分展示了两种类型的cell。
   
   2.闪电超市
   
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/SuperMarket.png)
   
   页面介绍：左侧为一个tableview，宽度为0.25*宽，右边是个VC的view，这个vc的view是定制化的，覆盖系统的self.view并且宽度等于0.75*宽。左边tableview点击cell时通过属性set方法传递给右边控制器信息，右边单击cell通过代理传递信息给SupermarketViewController。
   
   3.购物车
   
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/shopCar.png)
   
   页面介绍：此页面无数据时会显示一个提示去框框的view，这张png有数据的页面场景！从上面一直到收获备注都是属于tableview的headerView部分，下面是tableview的列表部分
   
   
   4.我的部分
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/Mine.png)
   
   页面介绍：此页面复杂部分在tableview的headerView（其实控件也很少），列表cell部分非常简单！具体见代码！
   
   5.我的收货地址
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/adress.png)
   
   页面介绍：这个页面是添加收货地址的，本地固定存储了三个地址！
   
   6.我的订单
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/my_order.png)
   
   页面介绍：这个页面显示我的所有订单。可点击查看订单详情！
   
   7.订单详情
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/order_status.png)
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/orderDetails.png)
   
   页面介绍：这个页面实现订单的具体详细信息。顶部自定义的NavigationBar的titleView，上面有个segment，当点击左侧的订单状态的时候，使用这个页面的tableview展示，当点击右侧的订单详情的时候隐藏本页面的tableview(注：本页面的tableview的cell左侧竖线是用三部分view画上去的，圆圈上面一小段、圆圈、圆圈下面一段)，展示另一个有订单详细信息的控制器的view（这个控制器作为本页面的childViewController，点击左侧显示本页面tableview隐藏子控制器的view，点击右侧隐藏本页面的tableview，显示子页面的view，具体详见代码）。
