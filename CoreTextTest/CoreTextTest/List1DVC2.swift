//
//  List1DVC2.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/23.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class List1DVC2: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        }
        cell!.selectionStyle = .none
        for e in  cell!.contentView.subviews{
            let e = e as UIView
            e.removeFromSuperview()
        }
        cell?.contentView.backgroundColor = UIColor.red
        let view:UIView!
        switch indexPath.row {
        case 0:
            view = CTTextView2()
            let newView = view as!CTTextView2
            newView.frame = CGRect.init(x: 0, y: 0, width: Screen_W-20, height: newView.resultHeight)
            view.backgroundColor=UIColor.gray
        case 1:
            view = CTTextView3()
            let newView = view as!CTTextView3
            view.frame = CGRect.init(x: 0, y: 0, width: Screen_W, height: newView.totalHeight)
            // #MARK: - ???很明显整篇文章计算位置的方法有问题，换成下面的方式就完全不对了！
//            view = CTTextView3(frame: CGRect.init(x: 0, y: 0, width: Screen_W, height: Screen_W))
            view.backgroundColor=UIColor.gray
        default:
            view = CTTextView2(frame: CGRect.init(x: 0, y: 0, width: Screen_W, height: Screen_W))
            view.backgroundColor=UIColor.gray
        }
        cell?.contentView.addSubview(view)

        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height :CGFloat = 0
        if indexPath.row == 0 {
            let newView = CTTextView2()
            height = newView.resultHeight
//           height=Screen_W
        }else if indexPath.row==1{
           let view = CTTextView3()
           height=view.totalHeight
        }
        return height
    }
}
