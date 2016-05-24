//
//  CSRefreshBaseView.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/24.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit


/**
 刷新状态
 
 - CSRefreshStatePulling:        松开就可以进行刷新的状态
 - CSRefreshStateNormal:         普通状态
 - CSRefreshStateRefreshing:     正在刷新中的状态
 - CSRefreshStateWillRefreshing: 将要刷新
 */
enum CSRefreshState :Int {
    case CSRefreshStatePulling = 1
    case CSRefreshStateNormal  = 2
    case CSRefreshStateRefreshing = 3
    case CSRefreshStateWillRefreshing = 4
}


/**
 刷新控件的类型
 
 - CSRefreshViewTypeHeader: 下拉刷新
 - CSRefreshViewTypeFooter: 上拉刷新
 */
enum CSRefreshViewType : Int{
    case CSRefreshViewTypeHeader = -1 //下拉刷新
    case CSRefreshViewTypeFooter = 1 //上拉刷新
}


class CSRefreshBaseView: UIView {

    //.=======================================//
    //          MARK: 状态标签                  //
    //=======================================//
    private weak var statusLabel : UILabel? {
        
        let statusLb : UILabel = UILabel()
        
        statusLb.autoresizingMask = [.FlexibleWidth]
        statusLb.font = UIFont.boldSystemFontOfSize(13)
        statusLb.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        statusLb.backgroundColor = UIColor.clearColor()
        statusLb.textAlignment = .Center
        
        self.addSubview(statusLb)
        return statusLb
    }
    
    
    //.=======================================//
    //          MARK: 箭头                    //
    //=======================================//
    private weak var arrowImage : UIImageView?{
        
        let arrowImageTmp = UIImageView(image: UIImage(named: "arrow"))
        arrowImageTmp.autoresizingMask = [.FlexibleLeftMargin,.FlexibleRightMargin]
        self.addSubview(arrowImageTmp)
        
        return arrowImageTmp
    }
    
    
    //.=======================================//
    //          MARK: 菊花标识                 //
    //=======================================//
    
    private weak var activityView : UIActivityIndicatorView?{
        
        let activityTmp = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        
        //设置菊花bound
        activityTmp.bounds = self.arrowImage!.bounds
        activityTmp.autoresizingMask = self.arrowImage!.autoresizingMask
        self.addSubview(activityTmp)
        return activityTmp
        
    }
    
    //.=======================================//
    //          MARK: 刷新状态                 //
    //=======================================//
    var state : CSRefreshState!
    
    
    
    //.=======================================//
    //          MARK: 初始化方法               //
    //=======================================//
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CSRefreshConstStruct.CSRefreshViewHeight))
        self.autoresizingMask = [.FlexibleWidth]
        
        //设置背景颜色为透明
        self.backgroundColor = UIColor.clearColor()
        state = CSRefreshState.CSRefreshStateNormal
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
