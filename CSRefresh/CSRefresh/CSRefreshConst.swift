//
//  CSRefreshBase.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/24.
//  Copyright © 2016年 crash. All rights reserved.
//

import Foundation
import UIKit

struct CSRefreshConstStruct {
    
    //.=======================================//
    //          MARK: 上拉下拉View的高度        //
    //=======================================//
    static let CSRefreshViewHeight : CGFloat = 64.0
    
    //.=======================================//
    //          MARK: 刷新动画时间              //
    //=======================================//
    
    static let CSRefreshFastAnimationDuration = 0.25
    
    static let CSRefreshSlowAnimationDuration = 0.4
    
    
    //.=======================================//
    //          MARK: 上拉下拉提示描述          //
    //=======================================//
    
    static let CSRefreshFooterPullToRefresh = "上拉可以加载更多数据"
    
    static let CSRefreshFooterReleaseToRefresh = "松开立即加载更多数据"
    
    static let CSRefreshFooterRefreshing = "正在帮你加载数据..."
    
    static let CSRefreshHeaderPullToRefresh = "下拉可以刷新"
    
    static let CSRefreshHeaderReleaseToRefresh = "松开立即刷新"
    
    static let CSRefreshHeaderRefreshing = "正在帮你刷新..."
    
    
    //.=======================================//
    //          MARK:                         //
    //=======================================//
    static let CSRefreshHeaderTimeKey = "CSRefreshHeaderView"
    
    static let CSRefreshContentOffset = "contentOffset"
    
    static let CSRefreshContentSize = "contentSize"
    
    
    //.=======================================//
    //          MARK:           //
    //=======================================//
    
    //.******** 头部动态绑定指针 *********/
    static var  CSRefreshHeaderViewKey = "CSRefreshHeaderViewKey"
    
    static var CSReleaseToRefreshText = "releaseToRefreshText"
    
    static var CSRefreshingText = "refreshingText"
    
    static var CSPullToRefreshText = "pullToRefreshText"
    
    static var LastUpdateTime = "lastUpdateTime"
}