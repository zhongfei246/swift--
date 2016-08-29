//
//  HomeCell.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 25/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

enum HomeCellType: Int {

    case Horizontal = 0
    case Vertical = 1
}

class HomeCell: UICollectionViewCell {
    
    //初始化子控件
    private lazy var backImageView: UIImageView = {
    
        let backImageView = UIImageView()
        
        return backImageView
    }()
    
    private lazy var goodsImageView: UIImageView = {
    
        let goodsImageView = UIImageView()
            goodsImageView.contentMode = UIViewContentMode.ScaleAspectFit
        return goodsImageView
    }()
    //名称label
    private lazy var nameLabel: UILabel = {
    
        let nameLabel = UILabel()
        
        nameLabel.textAlignment = .Left
        nameLabel.font = HomeCollectionTextFont
        nameLabel.textColor = UIColor.blackColor()
        
        return nameLabel
    }()
    
    private lazy var fineImageView: UIImageView = {
    
        let fineImageView = UIImageView()
        fineImageView.image = UIImage(named: "jingxuan.png")
        
        return fineImageView
    }()
    
    private lazy var giveImageView: UIImageView = {
    
        let giveImageView = UIImageView()
        giveImageView.image = UIImage(named: "buyOne.png")
        
        return giveImageView
    }()
    
    private lazy var specificsLabel: UILabel = {
    
        let specificsLabel = UILabel()
        
        specificsLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        specificsLabel.textAlignment = .Left
        specificsLabel.font = UIFont.systemFontOfSize(12.0)
        
        return specificsLabel
    }()
    
    private var disCountPriceView: DiscountPriceView?
    
    private lazy var buyView: BuyView = {
    
        let buyView = BuyView()
        
        return buyView
    }()
    
    private var type: HomeCellType? {
    
        didSet {
        
            backImageView.hidden = !(type == HomeCellType.Horizontal)
            goodsImageView.hidden = (type == HomeCellType.Horizontal)
            nameLabel.hidden = (type == HomeCellType.Horizontal)
            fineImageView.hidden = (type == HomeCellType.Horizontal)
            giveImageView.hidden = (type == HomeCellType.Horizontal)
            specificsLabel.hidden = (type == HomeCellType.Horizontal)
            disCountPriceView?.hidden = (type == HomeCellType.Horizontal)
            buyView.hidden = (type == HomeCellType.Horizontal)
        }
    }
    
    var addButtonClick:((imageView: UIImageView) -> ())?
    
    //MARK： -便利构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        addSubview(backImageView)
        addSubview(goodsImageView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        weak var tempSelf = self
        buyView.clickAddShopCar = {()
        
            if tempSelf?.addButtonClick != nil {
            
                tempSelf!.addButtonClick!(imageView: tempSelf!.goodsImageView)
            }
           
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    //MARK: - 模型的set方法
    var activities: Activities? {
    
        didSet {
        
            self.type = .Horizontal
            backImageView.sd_setImageWithURL(NSURL(string: activities!.img!), placeholderImage: UIImage(named: "v2_placeholder_full_size"))
        }
    }
    
    var goods: Goods? {
    
        didSet {
        
            self.type = .Vertical
            goodsImageView.sd_setImageWithURL(NSURL(string: goods!.img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
            nameLabel.text = goods?.name
            if goods!.pm_desc == "买一赠一" {
            
                giveImageView.hidden = false
            } else {
            
                giveImageView.hidden = true
            }
            if disCountPriceView != nil {
            
                disCountPriceView!.removeFromSuperview()
            }
            disCountPriceView = DiscountPriceView(price: goods?.price, marketPrice: goods?.market_price)
            addSubview(disCountPriceView!)
            
            specificsLabel.text = goods?.specifics
            buyView.goods = goods
        }
    }
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
        goodsImageView.frame = CGRectMake(0, 0, width, width)
        nameLabel.frame = CGRectMake(5, width, width - 15, 20)
        fineImageView.frame = CGRectMake(5, CGRectGetMaxY(nameLabel.frame), 30, 15)
        giveImageView.frame = CGRectMake(CGRectGetMaxX(fineImageView.frame) + 3, fineImageView.y, 35, 15)
        specificsLabel.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(fineImageView.frame), width, 20)
        disCountPriceView?.frame = CGRectMake(nameLabel.x, CGRectGetMaxY(specificsLabel.frame), 60, height - CGRectGetMaxY(specificsLabel.frame))
        buyView.frame = CGRectMake(width - 85, height - 30, 80, 25)
    }
}
