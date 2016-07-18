//
//  UIScrollView+CSRefresh.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/23.
//  Copyright © 2016年 crash. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView{

    //
    var mj_contentInsetTop :CGFloat{
        
        get{
            
            return self.contentInset.top
        }
        
        set(contenInsetTop){
            
            var inset :UIEdgeInsets = self.contentInset
            inset.top = contenInsetTop
            self.contentInset = inset
        }
    }
    
    
    var mj_contentInsetBottom :CGFloat{
        
        get{
            
            return self.contentInset.bottom
            
        }
        
        set(contentInsetBotton){
            
            var inset :UIEdgeInsets = self.contentInset
            inset.bottom = contentInsetBotton
            self.contentInset = inset
        }
    }
    
    var mj_contentInsetLeft :CGFloat{
        
        get{
            
            return self.contentInset.left
        }
        
        
        set(contentInsetLeft){
            
            var inset :UIEdgeInsets = self.contentInset
            inset.left = contentInsetLeft
            self.contentInset = inset
            
        }
    }
    
    var mj_contentInsetRight :CGFloat{
        
        get{
            
            return self.contentInset.right
        }
        
        
        set(contentInsetRight){
            
            var inset :UIEdgeInsets = self.contentInset
            inset.right = contentInsetRight
            self.contentInset = inset
            
        }
    }
    
    //UIScrollView 当前显示区域的顶点相对UIScrollView.frame顶点的x轴方向的偏移量
    var mj_contentOffsetX  : CGFloat{
        
        get{
            
            return self.contentOffset.x
        }
        
        
        set(contentOffsetX){
            
            var offset : CGPoint = self.contentOffset
            offset.x = contentOffsetX
            self.contentOffset = offset
        }
    }
    
    ////UIScrollView 当前显示区域的顶点相对UIScrollView.frame顶点的Y轴方向的偏移量
    var mj_contentOffsetY : CGFloat{
        
        get{
            
            return self.contentOffset.y
        }
        
        set(contentOffsetY){
            
            var offset : CGPoint = self.contentOffset
            offset.y = contentOffsetY
            self.contentOffset = offset
        }
        
    }
    
    //重新设置UIScrollView 可显示区域的宽
    var mj_contentSizeWidth : CGFloat{
        
        get{
            
            return self.contentSize.width
        }
        
        set(width){
            
            var contentSize :CGSize = self.contentSize
            contentSize.width = width
            self.contentSize = contentSize
        }
    }

    //设置UIScrollView 可显示区域的高
    var mj_contentSizeHeight : CGFloat{
        
        get{
            
            return self.contentSize.height
        }
        
        set(height){
            
            var contentSize :CGSize = self.contentSize
            contentSize.height = height
            self.contentSize = contentSize
            
            
        }
    }
    
}

//MARK: Drop down refresh
extension UIScrollView{
    
    //.******** HeadView *********/
    weak var header :CSRefreshHeaderView?{
        
        get{
            

            return objc_getAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshHeaderViewKey) as? CSRefreshHeaderView
        }
        
        set{
            
            self.willChangeValueForKey(CSRefreshConstStruct.shareManager.CSRefreshHeaderViewKey)
            
            //动态绑定
            objc_setAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshHeaderViewKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            self.didChangeValueForKey(CSRefreshConstStruct.shareManager.CSRefreshHeaderViewKey)
        }
        
    }
    
    
    //.=======================================//
    //          MARK: 下拉刷新                 //
    //=======================================//

    
    
  public func dropDownToRefresh(handler:(Void->Void)?){
        
        if self.header == nil{
            
            let headerTmp = CSRefreshHeaderView.header
            self.addSubview(headerTmp)
            
            self.header = headerTmp
        }
        
        self.header?.refreshHandler = handler
    }
    
    /**
     移除下拉刷新表头控件
     */
  public  func removeHeader()->Void{
        
        self.header?.removeFromSuperview()
        self.header = nil
    }
    
    
    /**
     主动让下拉刷新头部控件进入刷新状态
     */
   public func headerBeginRefreshing()->Void{
        
        self.header?.beginRefreshing()
    }
    
    /**
     让下拉刷新头部控件停止刷新状态
     */
  public  func headerEndRefreshing()->Void{
        
        self.header?.endRefreshing()
    }
    
    
    /**
     设置下拉刷新头部控件的可见性
     
     :param: hidden (true 不可见，false 可见)
     */
   public  func setHeaderHidden(hidden:Bool)->Void{
        
        self.header?.hidden = hidden
    }
    
    
    /**
     获取下拉刷新头部控件的可见性
     
     :returns: (true 不可见，false可见)
     */
   public func isHeaderHidden()->Bool{
        
        return self.header!.hidden
    }
    
    
    /**
     判断头部是否在刷新
     
     :returns: （true 正处于刷新状态）
     */
   public func isHeaderRefreshing()->Bool{
        
        return self.header?.state == .CSRefreshStateRefreshing
    }
    
    
    //.=======================================//
    //          MARK: 头部刷新显示文本          //
    //=======================================//
   public var headerPullToRefreshText :String?{
        
        get{
            
            return self.header?.pullToRefreshText
        }
        
        set{
            
            self.header?.pullToRefreshText = newValue
        }
    }
    
   public var headerReleaseToRefreshText :String?{
        
        get{
            
            return self.header?.releaseToRefreshText
        }
        
        set{
            
            self.header?.releaseToRefreshText = newValue
        }
    }
    
   public var headerRefreshingText :String?{
        
        get{
            
            return self.header?.refreshingText
        }
        
        set{
            
            self.header?.refreshingText = newValue
        }
    }
}


//MARK: 
extension UIScrollView{
    
    
    var footer :CSRefreshFootView?{
        
        get{
            
            return objc_getAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshFootViewPointKey) as? CSRefreshFootView
        }
        
        
        set{
            
            self.willChangeValueForKey(CSRefreshConstStruct.shareManager.CSRefreshFootViewPointKey)
            
            objc_setAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshFootViewPointKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            self.didChangeValueForKey(CSRefreshConstStruct.shareManager.CSRefreshFootViewPointKey)
        }
    }
    
    /**
     上拉刷新
     
     :param: handler 上拉刷新闭包
     */
   public func pullUpToRefresh(handler:(Void->Void)?)->Void{
        
        if self.footer == nil {
            
            let footerTemp : CSRefreshFootView = CSRefreshFootView()
            
            self.addSubview(footerTemp)
            
            self.footer = footerTemp
        }
        
        self.footer?.refreshHandler = handler
    }
    
    /**
     移除上拉刷新尾部控件
     */
   public  func removeFooter()->Void{
        
        self.footer?.removeFromSuperview()
        self.footer = nil
        
    }
    
    /**
     主动进入刷新状态
     */
    func footerBeginRefreshing()->Void{
        
        self.footer?.beginRefreshing()
    }
    
    /**
     停止刷新
     */
   public func footerEndRefresh()->Void{
        
        self.footer?.endRefreshing()
    }
    
    
    /**
     设置是否隐藏尾部刷新控件
     
     :param: hidden 隐藏状态(true = 隐藏)
     */
    public func setFooterHidden(hidden :Bool) ->Void{
        
        self.footer?.hidden = hidden
    }
    
    /**
     获取尾部刷新控件隐藏状态
     
     :returns: true = 隐藏
     */
    public func isFooterHidden()->Bool{
        
        return self.footer!.hidden
    }
    
    
    //.=======================================//
    //          MARK: 设置尾部刷新控件提示文本    //
    //=======================================//
    
   public var footerPullToRefreshText :String?{
        
        get{
            
           return self.footer?.pullToRefreshText
        }
        
        set{
            
            self.footer?.pullToRefreshText = newValue
        }
    }
    
    
   public var footerReleaseToRefreshText : String?{
        
        get{
            
            return self.footer?.releaseToRefreshText
        }
        
        
        set{
            
            self.footer?.releaseToRefreshText = newValue
        }
    }
    
    
   public var footerRefreshingText: String?{
        
        get{
            
            return self.footer?.refreshingText
        }
        
        set{
            
            self.footer?.refreshingText = newValue
        }
    }
}


