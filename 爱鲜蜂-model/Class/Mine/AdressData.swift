//
//  AdressData.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 7/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class AdressData: NSObject, DictModelProtocol {

    var code: Int = -1
    var msg: String?
    var data: [Adress]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Adress.self)"];
    }
    
    class func loadMyAdressData(completion:(data:AdressData?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("MyAdress", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
        
            let dict: NSDictionary = (try!NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: AdressData.self) as? AdressData
            
            completion(data: data, error: nil)
        }
    }
    
}

class Adress: NSObject {
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
}