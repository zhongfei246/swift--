//
//  WebViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 30/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {

    private var webView = UIWebView(frame: ScreenBounds)
    private var urlStr: String?
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRectMake(0, 0, ScreenWidth, 3))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(webView)
        webView.addSubview(loadProgressAnimationView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(navigationTitle: String, urlStr: String) {
    
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
        self.urlStr = urlStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildRightItemBarButton()
        
        view.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        webView.scalesPageToFit = true;
    webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none';");
    webView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout='none';")
        view.addSubview(webView)
        webView.addSubview(loadProgressAnimationView)
    }
    
    func buildRightItemBarButton() {
    
        let rightButton = UIButton(frame: CGRectMake(0 ,0 ,60,44))
        rightButton.setImage(UIImage(named: "v2_refresh"), forState: .Normal)
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        rightButton.addTarget(self, action: "refreshClick", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    //MARK: - Action
    func refreshClick() {
    
        if urlStr != nil && urlStr!.characters.count > 1 {
        
            webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr!)!))
        }
    }
    
}

extension WebViewController: UIWebViewDelegate {

    func webViewDidStartLoad(webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}

