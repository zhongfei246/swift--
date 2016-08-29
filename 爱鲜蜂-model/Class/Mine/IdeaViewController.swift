//
//  IdeaViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 24/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

@objc protocol IdeaViewControllerDelegate: NSObjectProtocol{

   optional func sendSuggestionSuceesMarkToMineVC()
}

class IdeaViewController: BaseViewController {

    //属性
    private var topMarkLabel:UILabel!
    private var textView: UITextView!
    weak var delegate:IdeaViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationBar
        buildNavigationBar()
        
        //UI
        buildMarkLabel()
        
        //输入框
        buildTextView()
    }
    
    //NavigationBar
    private func buildNavigationBar() {
    
        navigationItem.title = "意见反馈"
        
        let btn: UIButton = UIButton(frame: CGRectMake(0,0,40,40))
        btn.setTitle("发送", forState: .Normal)
        btn.setTitle("发送", forState: .Selected)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        btn.addTarget(self, action: "sendSuggestion", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    //MARK: -UI
    private func buildMarkLabel() {
    
        topMarkLabel = UILabel(frame: CGRectMake(10 ,10 ,ScreenWidth-20 , 50))
        topMarkLabel.font = UIFont.systemFontOfSize(14.0)
        topMarkLabel.text = "您的批评和建议能帮助我们更好的完善产品，请留下您宝贵的意见！谢谢！"
        topMarkLabel.numberOfLines = 0
        view.addSubview(topMarkLabel)
    }
    
    private func buildTextView() {
    
        textView = UITextView(frame: CGRectMake(10,60,ScreenWidth-20,120))
        textView.text = "请输入您的宝贵意见！（300字以内）"
        textView.backgroundColor = UIColor.whiteColor()
        textView.delegate = self
        view.addSubview(textView)
    }
    
    // Action
    func sendSuggestion() {
    
        if textView.text == nil || 0 == textView.text?.characters.count {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入意见,心里空空的")
        } else if textView.text?.characters.count < 5 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入超过5个字啊亲~")
        } else if textView.text?.characters.count >= 300 {
            ProgressHUDManager.showImage(UIImage(named: "v2_orderSuccess")!, status: "说的太多了,臣妾做不到啊~")
        } else {
        
            ProgressHUDManager.showWithStatus("发送中")
            weak var tempSelf = self
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                //调用代理
                if tempSelf!.delegate != nil {
                    
                    if tempSelf!.delegate!.respondsToSelector("sendSuggestionSuceesMarkToMineVC"){
                        
                        tempSelf?.navigationController?.popViewControllerAnimated(true)
                        tempSelf!.delegate!.sendSuggestionSuceesMarkToMineVC!()
                    }
                }
            })
            
        }
    }
}

//MARK: 协议实现
extension IdeaViewController: UITextViewDelegate {

    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
    }
}
