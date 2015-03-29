//
//  CustomCell.swift
//  SqliteSelect
//
//  Created by Smith on 2015/3/27.
//  Copyright (c) 2015年 Smith-Lab. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var labelId = UILabel()
    var labelName = UILabel()
    var labelMail = UILabel()
    var labelPhone = UILabel()
    
    func setCell(theLabelId:Int32, theLabelName:String, thelabelMail:String, thelabelPhone:Int32){
        
        labelId.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        labelName.frame = CGRect(x: 60, y:10, width: self.contentView.bounds.width - 60, height: 30)
        labelMail.frame = CGRect(x: 60, y: 27, width: (self.contentView.bounds.width/2) - 35, height: 30)
        labelPhone.frame = CGRect(x: (self.contentView.bounds.width/2) + 35, y: 27, width: (self.contentView.bounds.width/2) - 35, height: 30)
        
        self.labelId.text = String(theLabelId)
        self.labelId.textAlignment = .Center
        self.labelName.text = theLabelName
        self.labelMail.text = thelabelMail
        self.labelPhone.text = String(thelabelPhone)
        
        self.labelId.font =  UIFont(name: "Futura-Medium", size: 40)
        self.labelName.font =  UIFont(name: "Futura-Medium", size: 20)
        self.labelMail.font =  UIFont(name: "Futura-Medium", size: 12)
        self.labelPhone.font =  UIFont(name: "Futura-Medium", size: 11)
        
        self.labelId.textColor = UIColor(red: 0.996, green: 0.984, blue: 0.604, alpha: 1)
        self.labelName.textColor = UIColor(red: 0.996, green: 0.984, blue: 0.604, alpha: 1)
        self.labelMail.textColor = UIColor(red: 0.996, green: 0.984, blue: 0.604, alpha: 1)
        self.labelPhone.textColor = UIColor(red: 0.996, green: 0.984, blue: 0.604, alpha: 1)
        
        self.labelId.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.labelName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.labelMail.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.labelPhone.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        contentView.addSubview(labelId)
        contentView.addSubview(labelName)
        contentView.addSubview(labelMail)
        contentView.addSubview(labelPhone)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
