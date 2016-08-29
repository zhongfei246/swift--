//
//  HelpDetailViewController.swift
//  LoveFreshBenText
//
//  Created by lizhongfei on 19/8/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit

class HelpDetailViewController: BaseViewController {

    private var questionTableView: LFBTableView?
    private var questions: [Question]?
    private var lastOpenIndex = -1
    private var isOpenCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "常见问题"
        view.backgroundColor = UIColor.whiteColor()
        
        buildQuestionTableView()
        
        loadHelpData()
    }

    //MARK: build UI 
    private func buildQuestionTableView() {
    
        questionTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        questionTableView?.backgroundColor = UIColor.whiteColor()
        questionTableView?.registerClass(HelpHeadView.self, forHeaderFooterViewReuseIdentifier: "headView")
        questionTableView?.sectionHeaderHeight = 50
        questionTableView!.delegate = self
        questionTableView!.dataSource = self
        questionTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavgationH, right: 0)
        view.addSubview(questionTableView!)
    }
    
    private func loadHelpData() {
    
        weak var tempSelf = self
         Question.loadQuestions { (questions) -> () in
            tempSelf!.questions = questions
            tempSelf!.questionTableView?.reloadData()
        }
    }
}

//MARK: -tableview的数据源代理方法实现和headview代理方法实现

extension HelpDetailViewController: UITableViewDataSource,UITableViewDelegate,HelpHeadViewDelegate {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = AnswerCell.answerCell(tableView)
        
        cell.question = questions![indexPath.section]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastOpenIndex == section && isOpenCell {
        
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if lastOpenIndex == indexPath.section && isOpenCell {
        
            return questions![indexPath.section].cellHeight
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("headView") as? HelpHeadView
        headView!.tag = section
        headView?.delegate = self
        let question = questions![section]
        headView?.question = question
        
        return headView!
    }
    
    func HelpHeadViewDidClick(headView: HelpHeadView) {
        if lastOpenIndex != -1 && lastOpenIndex != headView.tag && isOpenCell { //这次点击的section头部，不是目前已经展开的section头部
        
            let headView = questionTableView?.headerViewForSection(lastOpenIndex) as? HelpHeadView
            headView?.isSelected = false
            
            let deleteIndexPaths = [NSIndexPath(forRow: 0, inSection: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: .Automatic)
        }
        
        if lastOpenIndex == headView.tag && isOpenCell { //点击的section头部是已经展开的，这次点击就关闭这个section的cell
        
            let deleteIndexPaths = [NSIndexPath(forRow: 0, inSection: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRowsAtIndexPaths(deleteIndexPaths, withRowAnimation: .Automatic)
            return
        }
        
        //记录新的lastIndex,并展开点击的section的cell（打开这个界面第一次点击section头部的时候执行下面的这几行，上面的不执行）
        lastOpenIndex = headView.tag
        isOpenCell = true
        let insertIndexPaths = [NSIndexPath(forRow: 0, inSection: headView.tag)]
        questionTableView?.insertRowsAtIndexPaths(insertIndexPaths, withRowAnimation: .Top)
        
    }
    
}

