//
//  List1VC.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/19.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit
import SnapKit
let Screen_W = UIScreen.main.bounds.size.width
let Screen_H = UIScreen.main.bounds.size.height
class List1TVC: UITableViewController {
    let label = UILabel(frame: CGRect.zero)
    let button1 = UIButton()
    let button2 = UIButton()
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(label)
       test1()
       initUI()
       }
    func initUI()  {
    //注意是tableview
        self.tableView.tableFooterView=UIView()
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        button1.backgroundColor=UIColor.black
        button2.backgroundColor=UIColor.red
        button1.setTitleColor(UIColor.white, for: .normal)
        button2.setTitleColor(UIColor.white, for: .normal)
        button1.setTitle("应用实例1", for: .normal)
        button2.setTitle("CTLine绘制、自动识别", for: .normal)
        button1.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(button2.snp.top).offset(-10)
        }
        button2.snp.makeConstraints { (make) in
//            make.width.equalTo(160)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.top).offset(Screen_H-64-10)
        }
        //action
         button1.addTarget(self, action: #selector(tapButton1(btn:)), for:.touchUpInside )
         button2.addTarget(self, action: #selector(tapButton2(btn:)), for: .touchUpInside)
    }
    func tapButton1(btn:UIButton)  {
        let vc = List1DVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tapButton2(btn:UIButton)  {
        let vc = List1DVC2()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func test1()    {
        let str = "这是一段测试的字符串 this is a string for test ! swift 中的字符串截取和range还挺复杂，包括字符串本身的构成就很复杂！随便抄的：I don't think the switch will fail. I mean the trailer itself has 25 million views, and counting. Plus it was shown in Jimmy Fallon, and all the other YouTube's are saying good things (some bad) about the system. So yeah, the marketing is awesome for the switch so far.﻿"
        let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: 20, weight: 15),NSForegroundColorAttributeName:UIColor.red]
        let attStr = NSMutableAttributedString.init(string: str, attributes: dict)
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location: 1, length: 2))
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 3, length: 2))
        // #MARK: - ???
//        let number =  NSNumber.init(integerLiteral: 1)//不太清楚int字面量如何快速转谎称number类型
        attStr.addAttribute(NSLigatureAttributeName, value:1, range:NSRange(location:30, length:100)) //连体好像没什么用
        attStr.addAttribute(NSStrikethroughStyleAttributeName, value:10, range:NSRange(location:10, length:50))
        label.preferredMaxLayoutWidth=Screen_W
        print(Screen_W)
        label.attributedText=attStr
        label.numberOfLines=0
        // #MARK: - ???
//        label.sizeToFit()//这个并不会自动换行，即使设置了最大宽度和linenum=0，但是下面的却会计算出来，只是没有改变label的大小罢了！
    let size =  label.sizeThatFits(CGSize.init(width: Screen_W, height: 0))
//        print("size is \(size)")
        label.frame = CGRect.init(origin: CGPoint.zero, size: size)
//        label.adjustsFontSizeToFitWidth = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
