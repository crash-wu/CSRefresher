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