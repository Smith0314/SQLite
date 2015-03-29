//
//  ViewController.swift
//  SqliteSelect
//
//  Created by Smith on 2015/3/25.
//  Copyright (c) 2015 Smith-Lab. All rights reserved.
//

import UIKit

class ViewController:  UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //database struct
    struct mem {
        var id:Int32
        var name:String
        var email:String
        var phone:Int32
        init(id:Int32, name:String, email:String, phone:Int32){
            self.id = id
            self.name = name
            self.email = email
            self.phone = phone
        }
    }
    
    var db:COpaquePointer = nil //database
    var statement:COpaquePointer = nil //data record
    var arrMem:Array<mem> = [] //data array
    var textFieldId:UITextField!
    var searchBtn:UIButton!
    var searchAllBtn:UIButton!
    var tableView:UITableView!
    var yellowColor:UIColor!
    var theFont:UIFont!
    var logo:UILabel!
    let cellIdentifier = "cell_indentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.backgroundColor = UIColor(red: 0.945, green: 0.416, blue: 0.443, alpha: 1)
        yellowColor = UIColor(red: 0.996, green: 0.984, blue: 0.604, alpha: 1)
        theFont = UIFont(name: "Futura-Medium", size: 15)
        
        var logoPosX:Int = Int(self.view.bounds.width / 2) - 50
        logo = UILabel()
        logo.frame = CGRect(x: logoPosX, y: 15, width: 100, height: 50)
        logo.font = UIFont(name:"untitled-font-1", size:35.0)
        logo.textColor = yellowColor
        logo.textAlignment = .Center
        logo.text = "s"
        
        //link ane open database
        var src:String = NSBundle.mainBundle().pathForResource("member", ofType: "sqlite")!
        if sqlite3_open(src, &db) != SQLITE_OK {
            var alertView:UIAlertView = UIAlertView(title: "Open fail", message: "Can't open database!", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            exit(1)
        }
        
        
        textFieldId = UITextField()
        textFieldId.frame = CGRect(x: 20, y: 70, width: view.bounds.width - 40, height: 30)
        textFieldId.textColor = yellowColor
        textFieldId.layer.borderColor = yellowColor.CGColor
        textFieldId.layer.borderWidth = 1.0
        textFieldId.delegate = self
        
        if textFieldId.text.isEmpty {
            textFieldId.text = " Enter number here..."
            textFieldId.textAlignment = .Center
            textFieldId.textColor = yellowColor
            textFieldId.font = theFont
        }
        
        searchBtn = UIButton()
        searchBtn.frame = CGRect(x: 20, y: 110, width: (view.bounds.width/2) - 25, height: 30)
        searchBtn.backgroundColor = yellowColor
        searchBtn.titleLabel?.font = theFont
        searchBtn.setTitleColor(UIColor(red: 0.945, green: 0.416, blue: 0.443, alpha: 1), forState: UIControlState.Normal)
        searchBtn.setTitle("Search", forState: UIControlState.Normal)
        searchBtn.addTarget(self, action: "searchBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        searchAllBtn = UIButton()
        searchAllBtn.frame = CGRect(x: (view.bounds.width/2) + 5, y: 110, width: (view.bounds.width/2) - 25, height: 30)
        searchAllBtn.backgroundColor = yellowColor
        searchAllBtn.titleLabel?.font = theFont
        searchAllBtn.setTitleColor(UIColor(red: 0.945, green: 0.416, blue: 0.443, alpha: 1), forState: UIControlState.Normal)
        searchAllBtn.setTitle("Search All", forState: UIControlState.Normal)
        searchAllBtn.addTarget(self, action: "searchAllBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        tableView = UITableView(frame:CGRectMake(20, 160, view.bounds.width - 40, view.bounds.height - 140), style:UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        tableView.registerClass(CustomCell.classForCoder(), forCellReuseIdentifier: cellIdentifier) //register custom cell
        tableView.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        tableView.separatorColor = yellowColor
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, view.bounds.width, 0);
        
        view.addSubview(logo)
        view.addSubview(textFieldId)
        view.addSubview(searchBtn)
        view.addSubview(searchAllBtn)
        view.addSubview(tableView)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldId.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        textFieldId.textAlignment = .Center
        textField.textColor = yellowColor
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func searchBtn(sender:UIButton){
        if textFieldId.text == "" {
            var alertView:UIAlertView = UIAlertView(title: "Enter Confirm", message: "Plese enter number", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }else{
            var n:Int? = textFieldId.text.toInt()! //transform field's text String to Int
            if n < 1 || n > 7 {
                var alertView:UIAlertView = UIAlertView(title: "Range Confirm", message: "Input over range", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }else{
                //load data with id
                var sql:NSString = "SELECT * FROM member WHERE s_id=" + textFieldId.text
                statement = nil
                if sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, nil) != SQLITE_OK {
                    var alertView:UIAlertView = UIAlertView(title: "Load fail", message: "Load database fail!", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                    exit(1)
                }
                arrMem.removeAll(keepCapacity: true)
                if sqlite3_step(statement) == SQLITE_ROW {
                    addItem()
                    sqlite3_finalize(statement) //close data record
                    tableView.reloadData()
                }
            }
        }
    }
    
    func searchAllBtn(sender:UIButton){
        var sql:NSString = "SELECT * FROM member"
        statement = nil
        if sqlite3_prepare(db, sql.UTF8String, -1, &statement, nil) != SQLITE_OK {
            var alertView:UIAlertView = UIAlertView(title: "Load fail", message: "Load database fail!", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            exit(1)
        }
        arrMem.removeAll(keepCapacity: true)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            addItem()
        }
        sqlite3_finalize(statement)
        tableView.reloadData()
    }
    
    func addItem() -> Void {
        var id = sqlite3_column_int(statement, 0)
        var theName = sqlite3_column_text(statement, 1)
        var name = String.fromCString(UnsafePointer<CChar>(theName))
        var theMail = sqlite3_column_text(statement, 2)
        var mail = String.fromCString(UnsafePointer<CChar>(theMail))
        var phone = sqlite3_column_int(statement, 3)
        var member:mem = mem(id: id, name: name!, email: mail!, phone: phone)
        arrMem.append(member)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomCell
        
        let theMem = arrMem[indexPath.row]
        cell.setCell(theMem.id, theLabelName: theMem.name, thelabelMail: theMem.email, thelabelPhone: theMem.phone)
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        return cell
        
    }
    
    //Row Height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 60.0
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

