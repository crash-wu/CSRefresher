//
//  CSRefreshBaseView.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/24.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

@objc protocol CSRefreshDelegate : NSObjectProtocol {
    
    optional func refreshHead()->Void
    
    optional func refreshFoot()->Void
}

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
    //          MARK: 刷新状态                 //
    //=======================================//
    
    var state : CSRefreshState = .CSRefreshStateNormal{
        
        didSet{
            
            self.settingLabelText()
        }

        willSet{
        
            //0.存储当前的contentInset
            if self.state != .CSRefreshStateRefreshing {
                scrollViewOriginalInset = self.scrollView.contentInset
            }
        
            // 1.一样的就直接返回(暂时不返回)
            if self.state == newValue {
        
                return
            }
            
            // 4.设置文字
          //  self.settingLabelText()
        
            // 2.根据状态执行不同的操作
            switch newValue {
                case .CSRefreshStateNormal:
                    //普通状态
                    if self.state == .CSRefreshStateRefreshing{
        
                        UIView.animateWithDuration(CSRefreshConstStruct.shareManager.CSRefreshSlowAnimationDuration * 0.6, animations: {
                                [weak self] in
                                self?.activityView?.alpha = 0.0
        
                            }, completion: {[weak self] (finished :Bool) in
        
                                //停止转圈圈
                              self?.activityView?.stopAnimating()
                              //恢复alpha
                             self?.activityView?.alpha = 1.0
                           })
        
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( UInt64(CSRefreshConstStruct.shareManager.CSRefreshSlowAnimationDuration ) * NSEC_PER_SEC)), dispatch_get_main_queue() , {
                        // 再次设置回normal
                        self.state = .CSRefreshStateNormal
                      })
                        //直接返回
                        return
        
                    }else{
                        //显示箭头
                        self.arrowImage?.hidden = false
                        
                        // 停止转圈圈
                        self.activityView?.stopAnimating()
                    }
                    break
                case .CSRefreshStatePulling :
                    
                    //显示箭头
                    self.arrowImage?.hidden = false
                    
                    //停止转圈圈
                    self.activityView?.stopAnimating()
                    break
                case .CSRefreshStateRefreshing :
                    // 开始转圈圈
                    self.activityView?.startAnimating()
                    
                    //隐藏箭头
                    self.arrowImage?.hidden = true
                    
                    //回调

                    guard refreshHandler == nil else{
                        
                        refreshHandler?()
                        return
                    }
                    break
                default:
                
                    break
                }

        }
    }
    
    var scrollView : UIScrollView = UIScrollView()
    
    var scrollViewOriginalInset : UIEdgeInsets?
    
    var refreshHandler:(Void->Void)?//声明一个刷新闭包

    //.=======================================//
    //          MARK: 状态标签                  //
    //=======================================//
   lazy  var statusLabel : UILabel? = {
    
        let statusLb : UILabel = UILabel()
        
        statusLb.translatesAutoresizingMaskIntoConstraints = true
        statusLb.autoresizingMask = [.FlexibleWidth]
        statusLb.font = UIFont.boldSystemFontOfSize(13)
        statusLb.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        statusLb.backgroundColor = UIColor.clearColor()
        statusLb.textAlignment = .Center
        self.addSubview(statusLb)
        return statusLb
    }()
    
    
    //.=======================================//
    //          MARK: 箭头                    //
    //=======================================//
    lazy  var arrowImage : UIImageView? = {
        
        let arrowImageTmp = UIImageView(image: UIImage(named: "arrow"))
        arrowImageTmp.translatesAutoresizingMaskIntoConstraints = true
        arrowImageTmp.autoresizingMask = [.FlexibleLeftMargin,.FlexibleRightMargin]
        self.addSubview(arrowImageTmp)
        
        return arrowImageTmp
    }()
    
    
    //.=======================================//
    //          MARK: 菊花标识                 //
    //=======================================//
    
    lazy  var activityView : UIActivityIndicatorView? = {
        
        let activityTmp = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        
        //设置菊花bound
        activityTmp.bounds = self.arrowImage!.bounds
        activityTmp.autoresizingMask = self.arrowImage!.autoresizingMask
        self.addSubview(activityTmp)
        return activityTmp
        
    }()
    

    
    
    
    //.=======================================//
    //          MARK: 初始化方法               //
    //=======================================//
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CSRefreshConstStruct.shareManager.CSRefreshViewHeight))
        
        self.autoresizingMask = [.FlexibleWidth]

        //设置背景颜色为透明
        self.backgroundColor = UIColor.clearColor()
        self.state = .CSRefreshStateNormal
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //箭头
        
        let arrowX = self.mj_width * 0.5 - 100
        
        self.arrowImage?.center = CGPointMake(arrowX, self.mj_height * 0.5)
        
        //指示器
        self.activityView?.center = self.arrowImage!.center
        
    }
    
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview)
        
        //旧的父控件移除监听
        
        superview?.removeObserver(self, forKeyPath: CSRefreshConstStruct.shareManager.CSRefreshContentOffset, context: nil)
        
        
        guard newSuperview == nil else{
            
            newSuperview?.addObserver(self, forKeyPath: CSRefreshConstStruct.shareManager.CSRefreshContentOffset, options: .New, context: nil)
            
            //设置宽度
            self.mj_width = newSuperview!.mj_width
            
            //设置位置
            self.mj_x = 0
            
            //记录UIScrollView
            self.scrollView = newSuperview as! UIScrollView
            //UIScrollView 最开始的ContentInset
            self.scrollViewOriginalInset = scrollView.contentInset
            
            return
        }
    }
    
    //.=======================================//
    //          MARK: 显示到屏幕上            //
    //=======================================//
    
    override  func drawRect(rect: CGRect) {
        //如果为将要刷新的状态，则将状态标记为刷新状态
        if self.state == .CSRefreshStateWillRefreshing {
            self.state = .CSRefreshStateRefreshing
        }
    }
    
    //.=======================================//
    //          MARK: 刷新 相关操作            //
    //=======================================//
    /**
     是否正在刷新
     
     :returns: true(正在刷新)
     */
    func isRefreshing() ->Bool{
        
        return self.state == .CSRefreshStateRefreshing
    }
    
    /**
     开始刷新
     */
    func beginRefreshing()->Void{
        
        
        if self.state == CSRefreshState.CSRefreshStateRefreshing{
            //如果是正在刷新状态
            
            //刷新方法回调
            guard refreshHandler == nil else{
                
                refreshHandler?()
                return
            }
            
        }else{
            //如果不是正在刷新状态
            if self.window != nil{
                self.state = .CSRefreshStateRefreshing
                
            }else{
                
                state = .CSRefreshStateRefreshing
                super.setNeedsDisplay()
            }
            
        }
    }
    
    
    /**
     结束刷新
     */
    func endRefreshing()->Void{
        
        let delayInSeconds = 0.3
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( UInt64(delayInSeconds) * NSEC_PER_SEC))
        
        dispatch_after(popTime, dispatch_get_main_queue()) { 
            [weak self] in
            
            self?.state = .CSRefreshStateNormal
        }
    }
    
    //.=======================================//
    //          MARK: 设置状态                //
    //=======================================//
    
    var pullToRefreshText :String? {
        
        get{
            
            return objc_getAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSPullToRefreshText) as? String
        }
        
        set{
            
            objc_setAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSPullToRefreshText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.settingLabelText()
        }
    }
    
    var releaseToRefreshText :String?{
        get{
            
            return objc_getAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSReleaseToRefreshText) as? String
        }
        
        set{

            objc_setAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSReleaseToRefreshText, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC )
            self.settingLabelText()
        }
    }
    
    var refreshingText :String?{
        
        get{
            
            return  objc_getAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshingText) as? String
        }
        
        set{
            
            objc_setAssociatedObject(self, &CSRefreshConstStruct.shareManager.CSRefreshingText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.settingLabelText()
        }
    }
    
    
    func settingLabelText()->Void{
        
        switch state {
        case .CSRefreshStateNormal:
            //设置文字
            statusLabel?.text = self.pullToRefreshText
            break
        case .CSRefreshStatePulling :
            
            statusLabel?.text = self.releaseToRefreshText
            break
        case .CSRefreshStateRefreshing :
           statusLabel?.text = self.refreshingText
            break
        default:
            break
        }
        
    }
    
    
    deinit{
        
        self.removeObserver(self, forKeyPath: CSRefreshConstStruct.shareManager.CSRefreshContentOffset, context: nil)
        
        self.removeObserver(self, forKeyPath: CSRefreshConstStruct.shareManager.CSRefreshContentSize)
        
    }
    
}
