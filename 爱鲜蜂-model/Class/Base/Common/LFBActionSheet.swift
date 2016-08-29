//
//  LFBActionSheet.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 6/6/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

enum ShareType: Int{

    case WeiXinMyFriend = 1
    case WeiXinCircleOfFriends = 2
    case SinaWeiBo = 3
    case QQZone = 4
}


class LFBActionSheet: NSObject, UIActionSheetDelegate {

    private var selectedShareType: ((shareType: ShareType) -> ())?
    private var actionSheet: UIActionSheet?
    
    func showActionSheetViewShowInView(inView: UIView,selectedShareType: ((shareType: ShareType) -> ())) {
    
        actionSheet = UIActionSheet(title: "分享到", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "微信好友","微信朋友圈","新浪微博","QQ空间")
        
        self.selectedShareType = selectedShareType
        
        actionSheet?.showInView(inView)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
        if selectedShareType != nil {
        
            switch buttonIndex {
            
            case ShareType.WeiXinMyFriend.rawValue:
                selectedShareType!(shareType: .WeiXinMyFriend)
                break
                
            case ShareType.WeiXinCircleOfFriends.rawValue:
                selectedShareType!(shareType: .WeiXinCircleOfFriends)
                break
                
            case ShareType.SinaWeiBo.rawValue:
                selectedShareType!(shareType: .SinaWeiBo)
                break
                
            case ShareType.QQZone.rawValue:
                selectedShareType!(shareType: .QQZone)
                break
                
            default:
                break
                
            }
        }
    }
}
