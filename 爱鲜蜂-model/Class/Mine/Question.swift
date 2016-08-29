//
//  Question.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 19/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class Question: NSObject {

    var everyRowHeight: [CGFloat] = []
    var cellHeight: CGFloat = 0
    var title: String?
    var texts: [String]? {
    
        didSet {
        
            let maxSize = CGSizeMake(ScreenWidth - 40, 100000)
            for i in 0..<texts!.count {
                let str = texts![i] as NSString
                let rowHeight: CGFloat = str.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil).size.height + 14
                cellHeight += rowHeight
                everyRowHeight.append(rowHeight)
            }
        }
    }
    
    class func question(dict: NSDictionary) -> Question {
        let question = Question()
        question.title = dict.objectForKey("title") as? String
        question.texts = dict.objectForKey("texts") as? [String]
        
        return question
    }
    
    class func loadQuestions(complete: ([Question] -> ())) {
        let path = NSBundle.mainBundle().pathForResource("HelpPlist", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        
        var questions: [Question] = []
        if array != nil {
            for dic in array! {
                questions.append(Question.question(dic as! NSDictionary))
            }
        }
        complete(questions)
    }
}
