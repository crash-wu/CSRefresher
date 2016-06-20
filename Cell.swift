//
//  Cell.swift
//  CSRefresh
//
//  Created by 吴小星 on 16/6/20.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    var label : UILabel!
    var line : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        label = UILabel(frame: CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height))
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.blackColor()

        
        line = UIView(frame: CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1))
        
        self.contentView.addSubview(line)
        
        line.backgroundColor = UIColor.grayColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
