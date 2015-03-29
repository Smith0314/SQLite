//
//  SecondViewController.swift
//  SqliteSelect
//
//  Created by Smith on 2015/3/29.
//  Copyright (c) 2015年 Smith-Lab. All rights reserved.
//



import UIKit

class SecondViewController: UIViewController {
    
        var label:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label=UILabel()
        label!.frame=CGRectMake(110,40,100,20)
        label!.backgroundColor=UIColor.greenColor()
        label!.text="hello world!"
        label!.textAlignment = .Center
        self.view.addSubview(label!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
