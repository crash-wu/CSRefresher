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
    
    
   override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        //设置位置
        self.mj_y = self.mj_y - self.mj_height
    }
    
    //.=======================================//
    // MARK: 监听UIScrollview 的contentOffset属性          //
    //=======================================//

   override  func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        //没有交互就直接返回
        if !self.userInteractionEnabled || (self.alpha <= 0.01 || self.hidden) {
            return
        }
    
        //如果正在刷新，直接放回
        if self.state == .CSRefreshStateRefreshing {
            return
        }
    
        if CSRefreshConstStruct.CSRefreshContentOffset == keyPath {
            
            self.adjustStateWithContentOffset()
        }
    
    }
    
    
    //.******** 调整状态 *********/
    
    func adjustStateWithContentOffset()->Void{
        
        //当前contentOffSet 
        let currentOffsetY :CGFloat = self.scrollView.mj_contentOffsetY
        
        //头部控件刚好出现的offSetY 
        let happenOffsetY :CGFloat = -(self.scrollViewOriginalInset?.top)!
        
        //如果向上滚动看不见头部控件，直接返回
        
        if currentOffsetY >= happenOffsetY{
            return
        }
        
        if self.scrollView.dragging {
            
            //普通状态 与即将刷新的临界点
            let normal2pullingOffsetY :CGFloat = happenOffsetY  - self.mj_height
            
            if self.state == .CSRefreshStateNormal && currentOffsetY < normal2pullingOffsetY {
                
                //转为即将刷新状态
                self.state = .CSRefreshStatePulling
            }else if self.state == .CSRefreshStatePulling && currentOffsetY >= normal2pullingOffsetY {
                
                //转为普通状态 
                self.state = .CSRefreshStateNormal
            }
        }else if self.state == .CSRefreshStatePulling{
            
            //手松开，开始刷新
            self.state = .CSRefreshStateRefreshing
        }
        
    }
    
    //.******** 重写父类的state属性 *********/
    override var state : CSRefreshState{
       
        get{
            
            return self.state
        }
        
        set{
            
            //如果值相同，则返回
            if self.state == newValue {
                return
            }
            
            //保存旧的状态
            let oldState :CSRefreshState = self.state
            
            //调用父类的方法
            super.state = newValue
            
            //根据状态执行不同的操作
            switch state {
            case .CSRefreshStateNormal:
                //下拉可以刷新
                if oldState == CSRefreshState.CSRefreshStateRefreshing {
                    
                    //箭头翻转
                    self.arrowImage?.transform = CGAffineTransformIdentity
                    
                    //保存刷新时间
                    self.lastUpdateTime = NSDate()
                    
                    
                    UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshSlowAnimationDuration, animations: { 
                        
                        self.scrollView.mj_contentInsetTop = self.scrollView.mj_contentInsetTop - self.mj_height
                    })
                }else{
                    
                    UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                        
                        self.arrowImage?.transform = CGAffineTransformIdentity
                    })
                }
                break
            case .CSRefreshStatePulling :
                //松开既可以刷新
                UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                    self.arrowImage?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
                
                break
            case .CSRefreshStateRefreshing :
                //正在刷新中
                UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                    //增加滚动区域
                    let top :CGFloat = self.scrollViewOriginalInset!.top + self.mj_height
                    self.scrollView.mj_contentInsetTop = top
                    
                    //设置滚动位置
                    self.scrollView.mj_contentOffsetY = self.scrollView.mj_contentOffsetY  - top
                    
                })
                break
            default:
                
                break
            }
        }
    }
    
}
