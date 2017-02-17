//
//  TextKitVC2.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/7.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class TextKitVC2: UIViewController {
    let label = TextKitVC2Label()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        label.frame = CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 400)
        label.backgroundColor=UIColor.cyan
        label.numberOfLines=0
        view.addSubview(label)
        label.text = "我好想好想好想tell you that I love You So S😯😯😯😯😯😯！！！http://www.baidu.com 好吧，就这样"
        // Do any additional setup after loading the view.
        let tf = UITextField.init()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.lightGray
        self.view.addSubview(tf)
        tf.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.centerX.equalTo(label.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        tf.addTarget(self, action: #selector(changeTf(tf:)), for: .editingChanged)
    }
    func changeTf(tf:UITextField)  {
        label.text = tf.text
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
