//
//  MyViewController.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/6/5.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit


class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView : UITableView?
    var count : Int = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: .Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
        tableView?.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        
        tableView?.separatorStyle = .None

   /*     tableView?.dropDownToRefresh({ (_) in
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                
                self?.tableView?.header?.endRefreshing()
            }
            
        })*/
        tableView?.headerPullToRefreshText = "下拉刷新"
        tableView?.headerReleaseToRefreshText = "松开马上刷新"
        tableView?.headerRefreshingText = "正在加载..."
        
        
        
        tableView?.pullupToRefresh ({ (_) in
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                
                self?.count = (self?.count)! + 10
                
                self?.tableView?.reloadData()
                self?.tableView?.footer?.endRefreshing()
            }
            
        })
        
        tableView?.footerPullToRefreshText = "上拉加载更多"
        tableView?.footerReleaseToRefreshText = "重开马上加载"
        tableView?.footerRefreshingText = "正在加载..."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? Cell
        
        if cell == nil{
            
            cell = Cell(style: .Default, reuseIdentifier: cellID)
            
        }

        cell?.label.text = "测试单元格:\(indexPath.row)"
        return cell!
        
    }
    

}
