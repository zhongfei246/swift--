//
//  AdressCell.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 12/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class AdressCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let adressLabel = UILabel()
    private let lineView = UIView()
    private let modifyImageView = UIImageView()
    private let bottomView = UIView()
    
    var modifyClickCallBack:(Int -> Void)?
    
    //设置子控件的值
    var adress: Adress? {
    
        didSet {
        
            nameLabel.text = adress!.accept_name
            phoneLabel.text = adress!.telphone
            adressLabel.text = adress!.address
        }
    }
    
    //类方法获取cell
    
    static private let idenfier = "AdressCell"
    
    class func adressCell(tableView: UITableView, indexPath: NSIndexPath, modifyClickCallBack:(Int -> Void)) -> AdressCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(idenfier) as? AdressCell
        if cell == nil {
        
            cell = AdressCell(style: .Default, reuseIdentifier: idenfier)
        }
        cell?.modifyClickCallBack = modifyClickCallBack
        cell?.modifyImageView.tag = indexPath.row
        
        return cell!
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //通用设置
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.whiteColor()
        
        //nameLabel控件
        createNameLabel()
        
        //电话
        createPhoneLabel()
        
        //地址
        createAdressLabel()
        
        //图片左边的竖线
        createVerticalLineView()
        
        //创建能点击的修改地址图片
        createModifyImageView()
        
        //底部线（cell分割线）
        createButtomLineView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //布局cell上地的控件
    override func layoutSubviews() {
       
        super.layoutSubviews()
        
        //控件frame设置
        nameLabel.frame = CGRectMake(10, 15, 80, 20)
        phoneLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 15, 150, 20)
        adressLabel.frame = CGRectMake(10, CGRectGetMaxY(phoneLabel.frame) + 10, width * 0.6, 20)
        lineView.frame = CGRectMake(width * 0.8, 10, 1, height - 20)
        modifyImageView.frame = CGRectMake(width * 0.8 + (width * 0.2 - 40), (height - 40) * 0.5, 40, 40)
        bottomView.frame = CGRectMake(0, height - 1, width, 1)
    }
    
    //name
    private func createNameLabel() {
    
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textColor = TextBlackColor
        contentView.addSubview(nameLabel)
    }
    
    //电话
    private func createPhoneLabel() {
    
        phoneLabel.font = UIFont.systemFontOfSize(14)
        phoneLabel.textColor = TextBlackColor
        contentView.addSubview(phoneLabel)
    }
    
    //地址
    private func createAdressLabel() {
    
        adressLabel.font = UIFont.systemFontOfSize(13)
        adressLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(adressLabel)
    }
    
    //添加线
    private func createVerticalLineView() {
    
        lineView.backgroundColor = UIColor.lightGrayColor()
        lineView.alpha = 0.2
        contentView.addSubview(lineView)
    }
    
    //创建能点击的修改地址图片
    private func createModifyImageView() {
    
        modifyImageView.image = UIImage(named: "v2_address_edit_highlighted")
        modifyImageView.contentMode = .Center
        modifyImageView.userInteractionEnabled = true
        contentView.addSubview(modifyImageView)
        
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: "modifyImageViewClick:")
        modifyImageView.addGestureRecognizer(tap)
    }
    
    //createModifyImageView的辅助函数(手势函数)
    func modifyImageViewClick(tap: UITapGestureRecognizer) {
    
        if modifyClickCallBack != nil {
        
            modifyClickCallBack!(tap.view!.tag)
        }
    }
    
    //创建底部view
    private func createButtomLineView() {
    
        bottomView.backgroundColor = UIColor.lightGrayColor()
        bottomView.alpha = 0.4
        contentView.addSubview(bottomView)
    }
}
