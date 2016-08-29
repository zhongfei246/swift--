//
//  CoupinRuleViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 18/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class CoupinRuleViewController: BaseViewController {

    private let webView = UIWebView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight - NavgationH))
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRectMake(0,0,ScreenWidth,3))
    
    var loadURLStr: String? {
    
        didSet {
        
            webView.loadRequest(NSURLRequest(URL: NSURL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
    
        didSet {
        
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        buildWebView()
    }

    //MARK: build UI
    private func buildWebView() {
    
        webView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView)
    }
}

//MARK: 协议实现
extension CoupinRuleViewController: UIWebViewDelegate {

    func webViewDidStartLoad(webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}

