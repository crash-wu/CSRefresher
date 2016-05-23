//
//  UIView+CSRefresh.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/5/23.
//  Copyright © 2016年 crash. All rights reserved.
//

import Foundation
import UIKit

extension UIView{

    //页面起点坐标X轴
    var mj_x :CGFloat{
        
        get{
            return self.frame.origin.x
        }
        
        set(oringinx){
            
            var frame :CGRect = self.frame
            frame.origin.x = oringinx
            self.frame = frame
        }
    }
    
    //页面原始点坐标Y轴
    var mj_y :CGFloat {
        
        get{
            
            return self.frame.origin.y
        }
        
        set(originy){
            
            var frame :CGRect = self.frame
            frame.origin.y = originy
            self.frame = frame
        }
    
    }
    
    //页面宽度
    var mj_width :CGFloat{
        
        get{
            
            return self.frame.size.width
        }
        
        set(width){
            
            var frame : CGRect = self.frame
            frame.size.width = width
            
            self.frame = frame
        }
    }
    
    
    //页面高度
    var mj_height :CGFloat{
        
        get{
            
            return self.frame.size.height
        }
        
        set(height){
            
            var frame :CGRect = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    //页面尺寸
    
    var mj_size : CGSize {
        
        get{
            
            return self.frame.size
        }
        
        set(size){
            
            var frame : CGRect = self.frame
            frame.size = size
            self.frame = frame
        }
    }
    
    //原点坐标
    var mj_origin : CGPoint{
        
        get{
            
            return self.frame.origin
        }
        
        set(origin){
            
            var frame :CGRect = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
}