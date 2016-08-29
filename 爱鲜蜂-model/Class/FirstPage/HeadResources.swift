//
//  HeadResources.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 23/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class HeadResources: NSObject, DictModelProtocol {

    var msg: String?
    var reqid: String?
    var data: HeadData?
    
    class func loadHomeHeadData(completion:(data: HeadResources?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("首页焦点按钮", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
        
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: HeadResources.self) as! HeadResources
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(HeadData.self)"]
    }
    
}

class HeadData: NSObject, DictModelProtocol {

    var focus: [Activities]?
    var icons: [Activities]?
    var activities: [Activities]?
    
    static func customClassMapping() -> [String : String]? {
    
        return ["focus" : "\(Activities.self)", "icons" : "\(Activities.self)", "activities" : "\(Activities.self)"]
    }
}

class Activities: NSObject {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}