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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.frame, style: .Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
        

        tableView?.addHeaderRefreshHandler({ () in
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                
                self?.tableView?.header?.endRefreshing()
            }
            
        })
        tableView?.headerPullToRefreshText = "下拉刷新"
        tableView?.headerReleaseToRefreshText = "松开马上刷新"
        tableView?.headerRefreshingText = "正在加载..."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableViewRefresh(){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
            
            self?.tableView?.header?.endRefreshing()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as UITableViewCell!
        
        if cell == nil{
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.text = "aaaaaa"
        return cell!
        
    }
    

}
