//
//  TextEffetcVC.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/9.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class TextEffetcVC: UIViewController {
    let label = TextEffetcLabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
           make.left.right.bottom.equalTo(self.view)
           make.top.equalTo(self.view).offset(64)
        }
        label.backgroundColor = UIColor.flatMint
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.font = UIFont.boldSystemFont(ofSize: 30)
        let tf = UITextField()
        self.view.addSubview(tf)
        tf.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.bottom.equalTo(view).offset(-40)
            make.centerX.equalTo(view)
        }
        tf.setcornerRadius(value: 5)
        
       tf.backgroundColor = UIColor.flatWhite
        tf.addTarget(self, action: #selector(changeText(tf:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    func changeText(tf:UITextField)  {
        label.text = tf.text
        print("change le")
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
