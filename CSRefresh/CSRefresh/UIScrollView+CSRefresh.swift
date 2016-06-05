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

extension UIScrollView{
    
    //.******** HeadView *********/
    weak var header :CSRefreshHeaderView?{
        
        get{
            
            return objc_getAssociatedObject(self, CSRefreshConstStruct.CSRefreshHeaderViewKey) as? CSRefreshHeaderView
        }
        
        set{
            
            self.willChangeValueForKey(CSRefreshConstStruct.CSRefreshHeaderViewKey)
            
            //动态绑定
            objc_setAssociatedObject(self, CSRefreshConstStruct.CSRefreshHeaderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            self.didChangeValueForKey(CSRefreshConstStruct.CSRefreshHeaderViewKey)
        }
        
    }
    
    
    //.=======================================//
    //          MARK: 下拉刷新                 //
    //=======================================//
    
    /**
     添加一个下拉刷新头部控件
     
     :param: target 目标
     :param: action 回调方法
     */
    func addHeaderWithTarget(target : AnyObject! ,action:Selector){
        
        //如果头部不存在，则创建
        
        if self.header == nil{
            
            let headerTmp = CSRefreshHeaderView.header
            self.addSubview(headerTmp)
            
            self.header = headerTmp
        }
        
        //设置回调方法，同目标
        self.header?.beginRefreshingTaget = target
        self.header?.beginRefreshingAction = action
    }
    
    /**
     移除下拉刷新表头控件
     */
    func removeHeader()->Void{
        
        self.header?.removeFromSuperview()
        self.header = nil
    }
    
    
    /**
     主动让下拉刷新头部控件进入刷新状态
     */
    func headerBeginRefreshing()->Void{
        
        self.header?.beginRefreshing()
    }
    
    /**
     让下拉刷新头部控件停止刷新状态
     */
    func headerEndRefreshing()->Void{
        
        self.header?.endRefreshing()
    }
    
    
    /**
     设置下拉刷新头部控件的可见性
     
     :param: hidden (true 不可见，false 可见)
     */
    func setHeaderHidden(hidden:Bool)->Void{
        
        self.header?.hidden = hidden
    }
    
    
    /**
     获取下拉刷新头部控件的可见性
     
     :returns: (true 不可见，false可见)
     */
    func isHeaderHidden()->Bool{
        
        return self.header!.hidden
    }
    
    
    /**
     判断头部是否在刷新
     
     :returns: （true 正处于刷新状态）
     */
    func isHeaderRefreshing()->Bool{
        
        return self.header?.state == CSRefreshState.CSRefreshStateRefreshing
    }
    
    
    //.=======================================//
    //          MARK: 头部刷新显示文本          //
    //=======================================//
    var headerPullToRefreshText :String?{
        
        get{
            
            return self.header?.pullToRefreshText
        }
        
        set{
            
            self.header?.pullToRefreshText = newValue
        }
    }
    
    var headerReleaseToRefreshText :String?{
        
        get{
            
            return self.header?.releaseToRefreshText
        }
        
        set{
            
            self.header?.releaseToRefreshText = newValue
        }
    }
    
    var headerRefreshingText :String?{
        
        get{
            
            return self.header?.refreshingText
        }
        
        set{
            
            self.header?.refreshingText = newValue
        }
    }
}