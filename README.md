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
 * The drop-down refresh
    tableView?.addHeaderRefreshHandler({ () in
    
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
    
       self?.tableView?.header?.endRefreshing()
     }
    })
