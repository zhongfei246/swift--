# swift--
这是一套swift写的仿爱鲜蜂app的代码（仿自昵称为维尼的小熊），代码中有汉语注释，清晰明了。

下面是一些关于图文功能性和技术架构的介绍：
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
   
   8.结算付款界面
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/pay.png)
   
   页面介绍：整个页面是个大的scrollView，然后里面都是分块画的views。
   
   9.常见问题界面
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/questions.png)
   
   页面介绍：这个页面展示的是常见的问题集结！单击section的头部可以看到问题的详细描述！
   
   10.扫一扫
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/saoyisao.png)
   
   页面介绍：这个扫一扫的话必须是真机而且授权了才能使用，如果不是真机或者摄像头没有授权就会出现这个页面的提示信息！扫一扫我在此部分代码中是直接跳到了一个扫到的链接地址对应的web页面，大家可根据自己的喜好去改动成你想要的情景。代理方法已写出并且里面有相应的注释（func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){}）！
   
   11.搜索
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/search.png)
   
   页面介绍：这个页面实现搜索功能，采用collectionView实现，搜索完成固定显示一些数据。
   
   12.商品详情
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/shop_instruction.png)
   
   页面介绍：这个页面是由点击商品展示的cell进来的。
   
   13.消息
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/system_message.png)
   
   页面介绍：这个页面是模拟展示的系统和用户消息。
   
   14.优惠券
   
   ![image](https://github.com/zhongfei246/swift--/blob/master/%E7%88%B1%E9%B2%9C%E8%9C%82-model/screenhots/youhuiquan.png)
   
   页面介绍：上面绑定电话是一个封装的view，下面是个tableview列表！


注：整个工程采用的所有数据均是本地化的数据，即所有的数据都是封装好的文件拖进的工程，具体可在Resource文件夹下看到。这个swift工程的代码纯粹是出于学习swift的目的而创建，具体仿制githup昵称为维尼的小熊的作者，在此非常感谢这位牛人！有什么问题可在githup上给我留言！谢谢！
