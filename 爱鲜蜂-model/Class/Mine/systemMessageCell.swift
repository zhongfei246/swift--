//
//  systemMessageCell.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 19/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class systemMessageCell: UITableViewCell {

    private var titleView: UIView?
    private var titleLabel: UILabel?
    private var showMoreButton: UIButton?
    private var subTitleView: UIView?
    private var subTitleLabel: UILabel?
    private var lineView: UIView?
    private var isSelected = false
    private weak var tableView: UITableView?

    var message: userMessage? {
    
        didSet {
        
            titleLabel?.text = message?.title
            subTitleLabel?.text = message?.content
            
            let attStr = NSMutableAttributedString(string: message!.content!)
            let attStyle = NSMutableParagraphStyle()
            attStyle.lineSpacing = 5.0
            var leng = (Int)(ScreenWidth - 40)
            if attStr.length < leng {
            
                leng = attStr.length
            }
            attStr.addAttribute(NSParagraphStyleAttributeName, value: attStyle, range: NSMakeRange(0, leng))
            
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.attributedText = attStr
            subTitleLabel?.sizeToFit()
            
            if subTitleLabel?.height >= 40 {
            
                subTitleLabel?.numberOfLines = 2
                showMoreButton?.hidden = false
            } else {
            
                showMoreButton?.hidden = true
                subTitleLabel?.numberOfLines = 1
                message?.subTitleViewHeightNomarl = 20 + (subTitleLabel?.height)!
                message?.cellHeight = 60 + message!.subTitleViewHeightNomarl + 20
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        contentView.backgroundColor = UIColor.clearColor()
        
        //子控件
        titleView = UIView()
        titleView!.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(titleView!)
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 0
        titleLabel!.textAlignment = NSTextAlignment.Left
        titleLabel!.font = UIFont.systemFontOfSize(15)
        titleView!.addSubview(titleLabel!)
        
        showMoreButton = UIButton(type: .Custom)
        showMoreButton!.setTitle("显示全部", forState: .Normal)
        showMoreButton!.titleLabel!.font = UIFont.systemFontOfSize(13)
        showMoreButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        showMoreButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        showMoreButton!.titleLabel?.textAlignment = NSTextAlignment.Center
        showMoreButton!.addTarget(self, action: "showMoreButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        showMoreButton?.hidden = true
        titleView!.addSubview(showMoreButton!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.lightGrayColor()
        lineView?.alpha = 0.2
        titleView?.addSubview(lineView!)
        
        subTitleView = UIView()
        subTitleView!.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(subTitleView!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.numberOfLines = 0
        subTitleLabel!.textAlignment = NSTextAlignment.Left
        subTitleLabel?.backgroundColor = UIColor.clearColor()
        subTitleLabel!.textColor = UIColor.lightGrayColor()
        subTitleLabel!.font = UIFont.systemFontOfSize(12)
        subTitleView!.addSubview(subTitleLabel!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "identifier"
    
    class func createSystemMessageCell(tableView: UITableView) -> systemMessageCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? systemMessageCell
        if cell == nil {
        
            cell = systemMessageCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.tableView = tableView
        
        return cell!
    }
    
    func showMoreButtonClick() {
    
        isSelected = !isSelected
        if isSelected {
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.sizeToFit()
            message!.cellHeight = 60 + (subTitleLabel?.height)! + 20 + 20
            message?.subTitleViewHeightSpread = (subTitleLabel?.height)! + 20
        } else {
            subTitleLabel?.numberOfLines = 2
            message!.cellHeight = 60 + message!.subTitleViewHeightNomarl + 20
        }
        
        tableView?.reloadData()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleView?.frame = CGRectMake(0, 0, width, 60)
        titleLabel?.frame = CGRectMake(20, 0, width - 40, 60)
        showMoreButton?.frame = CGRectMake(width - 80, 15, 60, 30)
        lineView?.frame = CGRectMake(20, 59, width - 20, 1)
        
        if !isSelected {
            subTitleView?.frame = CGRectMake(0, 60, width, 60)
            subTitleLabel?.frame = CGRectMake(20, 10, width - 40, 60 - 20)
        } else {
            subTitleView?.frame = CGRectMake(0, 60, width, (message?.subTitleViewHeightSpread)!)
            subTitleLabel?.frame = CGRectMake(20, 10, width - 40, message!.subTitleViewHeightSpread)
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.sizeToFit()
        }
    }
}
