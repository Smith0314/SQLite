# Sqlite-Select
SQLite, Read &amp; Search SQLite Database, built using Swift, SQLite, without storyboard


*Load & Search SQLite Database
-------------------------------------------------------------------
事先己透過 sqlitebrowser 這個工具完成了 member.sqlite 的文件並置入，內容為7筆連絡人資料

可於欄位輸入編號搜尋單筆資料或直接秀出全部資料

![image](https://github.com/Smith0314/Sqlite-Select/blob/master/screenshots/screenshots.png)

.

*Link With Obj-C
-------------------------------------------------------------------
用 Obj-C 標頭檔 BridgingHeader.h 撟接 SQLite

    #include <sqlite3.h>
	
.

*Creatc Database Object
-------------------------------------------------------------------
建立資料庫物件 db、資料庫記錄物件 statement ，類型皆為 COpaquePointer

    var db:COpaquePointer = nil //database
    var statement:COpaquePointer = nil //data record

.

*SQLite Database Link Path
-------------------------------------------------------------------
宣告資料庫文件路徑給 src 變數

    var src:String = NSBundle.mainBundle().pathForResource("member", ofType: "sqlite")!

.

*Load Data
-------------------------------------------------------------------
讀取資料並 Reload TableView

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
  
.

* Custom UITableViewCell
-------------------------------------------------------------------
自訂 TableViewCell 的樣式及配置

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
