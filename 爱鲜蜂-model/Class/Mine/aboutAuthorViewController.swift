//
//  aboutAuthorViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 4/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class aboutAuthorViewController: BaseViewController {

    private var authorLabel: UILabel!
    private var gitHubLabel: UILabel!
    private var sinaWeiBoLabel:UILabel!
    private var blogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //维尼的小熊图片
        buildAuthorImageView()
        
        //label
        buildTextLabel()
        
        //gitHup label
        buildGitHubLabel()
        
        //sina 微博
        buildSinaLabel()
        
        //技术博客
        buildBlogLabel()
        
        //下面的一排按钮
        buildURLButton()
    }

    //MARK: build UI
    private func buildAuthorImageView() {
    
        navigationItem.title = "关于作者"
        
        let authorImageView = UIImageView(frame: CGRectMake((ScreenWidth - 100)*0.5, 50, 100, 100))
        authorImageView.image = UIImage(named: "author")
        authorImageView.layer.cornerRadius = 15
        authorImageView.layer.masksToBounds = true
        view.addSubview(authorImageView)
    }
    private func buildTextLabel() {
    
        authorLabel = UILabel()
        authorLabel.textAlignment = .Center
        authorLabel.text = "维尼的小熊"
        authorLabel.sizeToFit()
        authorLabel.frame.origin.y = 170
        authorLabel.center.x = ScreenWidth*0.5
        view.addSubview(authorLabel)
    }
    private func buildGitHubLabel() {
    
        gitHubLabel = UILabel()
        buildTextLabel(gitHubLabel, text: "GitHub:" + "\(GitHubURLString)", tag: 1)
    }
    private func buildSinaLabel() {
    
        sinaWeiBoLabel = UILabel()
        buildTextLabel(sinaWeiBoLabel, text: "新浪微博:"+"\(SinaWeiBoURLString)", tag: 2)
    }
    private func buildBlogLabel() {
     
        blogLabel = UILabel()
        buildTextLabel(blogLabel, text: "技术博客:"+"\(BlogURLString)", tag: 3)
    }
    private func buildURLButton() {
    
        let buttonTitleArray = ["小熊的GitHub","小熊的微博","小熊的技术博客","中飞的Githup","QQ:1440182323"]
        let btnW:CGFloat = 80
        for i in 0...4{
        
            let btn = UIButton()
            btn.setTitle(buttonTitleArray[i], forState: .Normal)
            btn.backgroundColor = UIColor.whiteColor()
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds=true
            btn.titleLabel?.font = UIFont.systemFontOfSize(10)
            btn.tag = i
            btn.frame = CGRectMake(30 + CGFloat(i%3) * ((ScreenWidth - btnW * 3 - 60) / 2 + btnW), CGRectGetMaxY(blogLabel.frame) + 10 + (CGFloat)(40*(Int)(i/3)), btnW, 30)
            btn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            view.addSubview(btn)
        }
    }
    
    //MARK: 辅助函数-创建label
    private func buildTextLabel(label: UILabel,text: String,tag: Int) {
    
        label.text = text
        label.font = UIFont.systemFontOfSize(13)
        label.sizeToFit()
        label.userInteractionEnabled = true
        label.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        label.numberOfLines = 0
        
        switch tag {
        
        case 1: label.frame = CGRectMake(40, CGRectGetMaxY(authorLabel.frame)+20, gitHubLabel.width, gitHubLabel.height+10)
            break
        case 2: label.frame = CGRectMake(40, CGRectGetMaxY(gitHubLabel.frame)+10, ScreenWidth, sinaWeiBoLabel.height + 10)
            break
        case 3: label.frame = CGRectMake(40, CGRectGetMaxY(sinaWeiBoLabel.frame)+10, ScreenWidth-90, 40)
        default:break
        }
        
        label.tag = tag
        view.addSubview(label)
        
        //加手势
        let tap = UITapGestureRecognizer(target: self, action: "textLabelClick:")
        label.addGestureRecognizer(tap)
    }
    func textLabelClick(tap: UITapGestureRecognizer){
    
        switch tap.view!.tag {
        
        case 1: UIApplication.sharedApplication().openURL(NSURL(string: GitHubURLString)!)
            break
        case 2:UIApplication.sharedApplication().openURL(NSURL(string: SinaWeiBoURLString)!)
            break
        default:
            UIApplication.sharedApplication().openURL(NSURL(string: BlogURLString)!)
            break
        }
    }
    func btnClick(btn: UIButton){
    
        switch btn.tag {
        case 0: UIApplication.sharedApplication().openURL(NSURL(string: GitHubURLString)!)
            break
        case 1: UIApplication.sharedApplication().openURL(NSURL(string: SinaWeiBoURLString)!)
            break
        case 2: UIApplication.sharedApplication().openURL(NSURL(string: BlogURLString)!)
            break
        case 3: UIApplication.sharedApplication().openURL(NSURL(string: ZFBlogURLString)!)
            break
        default:
            break
        }
    }

}
