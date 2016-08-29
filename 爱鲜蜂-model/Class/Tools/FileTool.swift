//
//  FileTool.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 4/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class FileTool: NSObject {

    static let fileManager = NSFileManager.defaultManager()
    
    //计算单个文件的大小
    class func fileSize(path: String) -> Double {
        if fileManager.fileExistsAtPath(path) {
        
            var dict = try? fileManager.attributesOfItemAtPath(path)
            if let fileSize = dict![NSFileSize] as? Int {
            
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        return 0.0
    }
    
    //MARK: 计算整个文件夹的大小
    class func folderSize(path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExistsAtPath(path) {
        
            let chilerFiles = fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
            
                let tempPath = path as NSString
                let fileFullPathName = tempPath.stringByAppendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return folderSize
    }
    
    //清除文件
    class func cleanFolder(path: String,complete:() -> ()) {
        let chilerFiles = self.fileManager.subpathsAtPath(path)
        for fileName in chilerFiles! {
        
            let tempPath = path as NSString
            let fileFullPathName = tempPath.stringByAppendingPathComponent(fileName)
            if self.fileManager.fileExistsAtPath(fileFullPathName) {
            
                do {
                
                    try self.fileManager.removeItemAtPath(fileFullPathName)
                } catch _ {
                //这里捕获各种异常
                    print("异常")
                }
            }
        }
        complete()
    }
    
    //清除文件  异步
    class func cleanFolderAsync(path: String,complete:() -> ()) {
        let queue = dispatch_queue_create("cleanQueue", nil)
        dispatch_async(queue) { () -> Void in
            let chileFiles = self.fileManager.subpathsAtPath(path)
            for fileName in chileFiles! { //遍历
            
                let tempPath = path as NSString
                let fileFullPathName = tempPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                
                    do {
                     
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {
                    
                        
                    }
                }
            }
            complete()
        }
    }
}
