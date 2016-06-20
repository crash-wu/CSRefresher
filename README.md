# CSRefresher
pull to refresh UITableView/UICollectView


## CSRefresher 
* An easy way to  use pull-to-refresh

## Support what kinds of control to refresh
  * UITableView ,UICollectView


## Install 
      Install cocoapod 'CSRefresher'
      * Manual import :
       * Drag all file in the CSRefresher folder to project

## How to use CSRefresher
 # The drop-down refresh
 
   //UITableView 添加下拉刷新功能
      
    tableView?.dropDownToRefresh({ () in
    
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
     //结束刷新
       self?.tableView?.header?.endRefreshing()
     }
    })
    
    //添加提示文本
    tableView?.headerPullToRefreshText = "下拉刷新"
    tableView?.headerReleaseToRefreshText = "松开马上刷新"
    tableView?.headerRefreshingText = "正在加载..."

## Example

![(下拉刷新)](http://images.cnblogs.com/cnblogs_com/crash-wu/840824/o_Untitled1.gif)


 # The pull-up refresh 

        tableView?.pullUpToRefresh ({ (_) in

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in


                self?.tableView?.footer?.endRefreshing()
            }
        })
        tableView?.footerPullToRefreshText = "上拉加载更多"
        tableView?.footerReleaseToRefreshText = "重开马上加载"
        tableView?.footerRefreshingText = "正在加载..."
    
## Example 

![(上拉加载更多)](http://images.cnblogs.com/cnblogs_com/crash-wu/840824/o_pullUpToRefresh.gif)

