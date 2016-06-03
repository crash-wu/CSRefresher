//
//  CSRefreshHeaderView.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/6/3.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class CSRefreshHeaderView: CSRefreshBaseView {

    //.=======================================//
    //          MARK: 最后更新时间            //
    //=======================================//
    
    //.******** 时间显示条 *********/
    var lastUpdateTimeLabel :UILabel?{
        
        let lable = UILabel()
        lable.autoresizingMask = [.FlexibleWidth]
        lable.font = UIFont.boldSystemFontOfSize(12)
        lable.backgroundColor = UIColor.clearColor()
        lable.textAlignment = .Center
        lable.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        self.addSubview(lable)
        
        //加载时间
        self.lastUpdateTime =  NSUserDefaults.standardUserDefaults().objectForKey(CSRefreshConstStruct.CSRefreshHeaderTimeKey) as?NSDate
        return lable
    }
    
    
    //.******** 时间 *********/
    var lastUpdateTime : NSDate?{
       
        get{
            
            return objc_getAssociatedObject(self, "lastUpdateTime") as? NSDate
        }
        
        set{
            
            //归档
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: CSRefreshConstStruct.CSRefreshHeaderTimeKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            objc_setAssociatedObject(self, "lastUpdateTime", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            //更新时间
            self.updateTimeLabel()
        }
    }
    
    //.******** 更新时间 *********/
    func updateTimeLabel()->Void{
        
        guard lastUpdateTime != nil else{
            
            return
        }
        
        // 1.获得年月日
        let calendar = NSCalendar.currentCalendar()

        let unitFlags : NSCalendarUnit = [.Year,.Month,.Day,.Hour,.Minute]
        
        let cmp1 : NSDateComponents = calendar.components(unitFlags, fromDate: lastUpdateTime!)
        
        let cmp2 :NSDateComponents = calendar.components(unitFlags, fromDate: NSDate())
        // 2.格式化日期
        
        let  formatter = NSDateFormatter()
        if cmp1.day == cmp2.day{
            //今天
            formatter.dateFormat = "今天 HH:mm"
        }else if cmp1.year == cmp2.year{
            //今年
            formatter.dateFormat = "MM-dd HH:mm"
        }else{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        
        let time :String = formatter.stringFromDate(self.lastUpdateTime!)
        self.lastUpdateTimeLabel?.text = "最后更新:" + "\(time)"

    }
    
    //.=======================================//
    //          MARK: 单例                    //
    //=======================================//
    
    static let header = CSRefreshHeaderView()
    
    private  convenience init(){
        self.init(frame : CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.pullToRefreshText = CSRefreshConstStruct.CSRefreshHeaderPullToRefresh
        self.releaseToRefreshText = CSRefreshConstStruct.CSRefreshFooterReleaseToRefresh
        self.refreshingText = CSRefreshConstStruct.CSRefreshHeaderRefreshing
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let statusX :CGFloat = 0
        let statusY :CGFloat = 0
        let statusHeight :CGFloat = self.mj_height * 0.5
        let statusWidth :CGFloat = self.mj_width
        
        // 1.状态标签
        self.statusLabel?.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight)
        
         // 2.时间标签
        
        let lastUpdateY :CGFloat = statusHeight
        let lastUpdateX :CGFloat = 0
        let lastUpdateHeight :CGFloat = statusHeight
        let lastUpdateWidth :CGFloat = statusWidth
        self.lastUpdateTimeLabel?.frame = CGRectMake(lastUpdateX, lastUpdateY, lastUpdateWidth, lastUpdateHeight)
    }

}
