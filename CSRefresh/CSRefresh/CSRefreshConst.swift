//
//  CSRefreshBase.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/24.
//  Copyright © 2016年 crash. All rights reserved.
//

import Foundation
import UIKit

class  CSRefreshConstStruct  :NSObject{
    
   static  let shareManager = CSRefreshConstStruct()
    
    //.=======================================//
    //          MARK: 上拉下拉View的高度        //
    //=======================================//
     let CSRefreshViewHeight : CGFloat = 64.0
    
    //.=======================================//
    //          MARK: 刷新动画时间              //
    //=======================================//
    
     let CSRefreshFastAnimationDuration = 0.25
    
     let CSRefreshSlowAnimationDuration = 0.4
    
    
    //.=======================================//
    //          MARK: 上拉下拉提示描述          //
    //=======================================//
    
     let CSRefreshFooterPullToRefresh = "上拉加载更多数据"
    
     let CSRefreshFooterReleaseToRefresh = "松开立即"
    
     let CSRefreshFooterRefreshing = "正在加载数据..."
    
     let CSRefreshHeaderPullToRefresh = "下拉可以刷新"
    
     let CSRefreshHeaderReleaseToRefresh = "松开立即刷新"
    
     let CSRefreshHeaderRefreshing = "正在刷新..."
    
    
    //.=======================================//
    //          MARK:                         //
    //=======================================//
     let CSRefreshHeaderTimeKey = "CSRefreshHeaderView"
    
     let CSRefreshContentOffset = "contentOffset"
    
     let CSRefreshContentSize = "contentSize"
    
    
    //.=======================================//
    //          MARK:           //
    //=======================================//
    
    //.******** 头部动态绑定指针 *********/
     var  CSRefreshHeaderViewKey = "CSRefreshHeaderViewKey"
    
     var CSReleaseToRefreshText = "releaseToRefreshText"
    
     var CSRefreshingText = "refreshingText"
    
     var CSPullToRefreshText = "pullToRefreshText"
    
     var LastUpdateTime = "lastUpdateTime"
    
    
    //.******** 尾部动态绑定指针 *********/
     var CSRefreshFootViewPointKey = "CSRefreshFootViewpointKey"
}