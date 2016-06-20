//
//  CSRefreshFootView.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/6/15.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class CSRefreshFootView: CSRefreshBaseView {

    /**
     *  @author crash         crash_wu@163.com   , 16-06-15 21:06:12
     *
     *  @brief  单例
     */
    static let footer = CSRefreshFootView()
    
    //最后
    var lastRefreshCount : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置上拉刷新提示文本
        //上拉
        self.pullToRefreshText = CSRefreshConstStruct.CSRefreshFooterPullToRefresh
        
        //释放加载
        self.releaseToRefreshText = CSRefreshConstStruct.CSRefreshFooterReleaseToRefresh
        
        //正在加载 
        self.refreshingText = CSRefreshConstStruct.CSRefreshFooterRefreshing
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.statusLabel?.frame = self.bounds
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        //移除旧的父视图监听
        superview?.removeObserver(self, forKeyPath: CSRefreshConstStruct.CSRefreshContentSize)
        
        guard newSuperview == nil else{
            //添加视图变化监听
            newSuperview?.addObserver(self, forKeyPath: CSRefreshConstStruct.CSRefreshContentSize, options: .New, context: nil)
            
            //调整frame
            adjustFrameWithContenSize()
            return
        }
        
    }
    
    /**
     调整frame
     */
    private  func  adjustFrameWithContenSize()->Void{
        
        //UIScrollView 可显示区域的高
        let contenHeight :CGFloat = self.scrollView.mj_contentSizeHeight
        
         //UIScrollView 上拉的高度 ＝ UIScrollView.frame.height - 
        let scrollHeight :CGFloat = self.scrollView.mj_height - self.scrollViewOriginalInset!.top - self.scrollViewOriginalInset!.bottom
        
        self.mj_y = max(contenHeight, scrollHeight)
        
    }
    
    /**
     调整状态
     */
    private func  adjustStateWithContentOffset()->Void{
        
        //当前的contentOffsetY
        let currentOffsetY : CGFloat = self.scrollView.mj_contentOffsetY
        
        //尾部控件刚好出现时的offsetY
        let happenOffsety = happenOffsetY()
        
        //如果是向下滚动看不见尾部控件，直接返回
        
        if currentOffsetY <= happenOffsety {return}
        
        if self.scrollView.dragging {
            
            //普通状态与即将刷新的临界点
            let willRefreshingOffsetY :CGFloat = happenOffsety + self.mj_height
            
            if self.state == .CSRefreshStateNormal && currentOffsetY > willRefreshingOffsetY {
                //转为即将刷新状态
                self.state = .CSRefreshStatePulling
                
            }else if self.state == .CSRefreshStatePulling && currentOffsetY <= willRefreshingOffsetY{
                
                //转为普通状态
                self.state = .CSRefreshStateNormal
                
            }
            
        }else if self.state == .CSRefreshStatePulling{
            //如果出于即将刷新的边界时，放手则刷新
            //刷新状态
            self.state = .CSRefreshStateRefreshing
            
        }
        
    }
    
    
    //MARK: 设置状态 
    
    //重写父类的状态
   override  var state: CSRefreshState{
        
        get{
            
            return super.state
        }
        
        set{
            
            //如果值相同，则返回
            guard self.state != newValue else{
                
                return
            }
            
            //保存旧的状态
            let oldState : CSRefreshState = newValue
            
            //调用父类的方法
            super.state = newValue
            
            //根据状态来设置属性
            switch newValue {
            case .CSRefreshStateNormal:
                
                //刷新完毕
                if oldState == .CSRefreshStateRefreshing{
                    
                    self.arrowImage?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    
                    UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshSlowAnimationDuration, animations: { 
                        
                        self.scrollView.mj_contentInsetBottom = self.scrollViewOriginalInset!.bottom
                        
                    })
                }else{
                    
                    UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                        
                        self.arrowImage?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    })
                }
                
                
                let deltaH = heightForContentBreakView()
                let currentCount = totalCellCountInScrollView()
                
                if oldState == .CSRefreshStateRefreshing && deltaH > 0 && currentCount != self.lastRefreshCount{
                    
                    self.scrollView.mj_contentOffsetY = self.scrollView.mj_contentOffsetY
                }
                
                
                break
                
            case .CSRefreshStatePulling :
                //上拉过程，改变箭头方向
                UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                    
                    
                    self.arrowImage?.transform = CGAffineTransformIdentity
                })
                
                break
                
            case .CSRefreshStateRefreshing :
                
                //记录当前刷新的数量
                self.lastRefreshCount = totalCellCountInScrollView()
                
                
                UIView.animateWithDuration(CSRefreshConstStruct.CSRefreshFastAnimationDuration, animations: { 
                    
                    var  bottom : CGFloat = self.mj_height + self.scrollViewOriginalInset!.bottom
                    
                    let deltah : CGFloat = self.heightForContentBreakView()
                    
                    if deltah < 0 {
                        //如果UIScrollView内容高度小于view 高度
                        bottom = bottom - deltah
                    }
                    
                    self.scrollView.mj_contentInsetBottom = bottom
                    
                })
                
                break
            default:
                
                break
            }
        }
        
    }
    
    
    /**
     上拉控件刚刚出现时contentOffset.y
     
     :returns: contentOffset.y值
     */
    private func  happenOffsetY()->CGFloat{
        
        let deltaH :CGFloat = heightForContentBreakView()
        
        if deltaH > 0 {
            
            return deltaH - self.scrollViewOriginalInset!.top
        }else{
            
            return -self.scrollViewOriginalInset!.top
        }
    }
    
    /**
     scrollView的内容 超出 view 的高度
     
     :returns: 超出的高度值
     */
    private func heightForContentBreakView()->CGFloat{
        
        
        let height :CGFloat = self.scrollView.frame.size.height - self.scrollViewOriginalInset!.bottom - self.scrollViewOriginalInset!.top
        
        return self.scrollView.contentSize.height - height
    }
    
    
    /**
     计算UITableView 或者UICollectionView 的 cell数目
     
     :returns:  cell 数目
     */
    private func totalCellCountInScrollView()->Int{
        
        var totalCount  : Int = 0
        if self.scrollView.isKindOfClass(UITableView.self){
            
            let tableView : UITableView = self.scrollView as! UITableView
            
            for index in 0..<tableView.numberOfSections{
                
                totalCount = totalCount + tableView.numberOfRowsInSection(index)
            }
            
        }else if self.scrollView.isKindOfClass(UICollectionView.self ){
            
            let collectionView : UICollectionView = self.scrollView as! UICollectionView
            
            for index in 0..<collectionView.numberOfSections(){
                
                
                totalCount = totalCount + collectionView.numberOfItemsInSection(index)
            }
            
        }
        
        return totalCount
    }

}



extension CSRefreshFootView{
    
    /**
     UIScrollView 变化监听
     */
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if !self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden {
            return
        }
        
        if keyPath == CSRefreshConstStruct.CSRefreshContentSize {
            
            //调整frame
            adjustFrameWithContenSize()
            
        }else if keyPath == CSRefreshConstStruct.CSRefreshContentOffset{
            
            //如果正在处于刷新状态，直接返回
            if self.state == .CSRefreshStateRefreshing { return}
            
            //调整状态
            adjustStateWithContentOffset()
        }
    
    }

}
