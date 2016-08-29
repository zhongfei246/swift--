//
//  UserInfo.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 7/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class UserInfo: NSObject {

    private static let instance = UserInfo()
    
    private var allAdress: [Adress]?
    
    class var shareUserInfo: UserInfo {
    
        return instance
    }
    
    func hasDefaultAdress() -> Bool {
    
        if allAdress != nil {
        
            return true
        } else {
        
            return false
        }
    }
    
    func setAllAdress(adress: [Adress]) {
    
        allAdress = adress
    }

    func cleanAllAdress() {
    
        allAdress = nil
    }
    
    func defaultAdress() -> Adress? {
    
        if allAdress == nil {
        
            weak var tmpSelf = self
            
            AdressData.loadMyAdressData({ (data, error) -> Void in
                if data?.data?.count > 0 {
                
                    tmpSelf!.allAdress = data!.data!
                } else {
                
                    tmpSelf?.allAdress?.removeAll()
                }
            })
            
            return allAdress?.count > 1 ? allAdress![0] : nil
        } else {
        
            return allAdress![0]
        }
    
    }
    
    func setDefaultAdress(adress: Adress) {
    
        if allAdress != nil {
        
            allAdress?.insert(adress, atIndex: 0)
        } else {
        
            allAdress = [Adress]()
            allAdress?.append(adress)
        }
    }
    
}
