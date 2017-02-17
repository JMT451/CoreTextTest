//
//  ListVC2.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/24.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class List2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatLime
       let view =   ListVC2TestView()
       self.view.addSubview(view)
       view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64+10)
            make.left.equalTo(self.view).offset(10)
            make.right.bottom.equalTo(self.view).offset(-10)

       }
       view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
