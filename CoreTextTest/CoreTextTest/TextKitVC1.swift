//
//  TextKitVC1.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/6.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit
import Translucid
import ChameleonFramework
class TextKitVC1: UIViewController {
    let textArr = [
        "Jerry && Tom",
        "白雪公主!!!七个小矮人",
        "@弟弟@",
        "哈哈😝What is 1234567890 ?",
        " 谁道群生性命微，一般骨肉一般皮。\n劝君莫打枝头鸟，子在巢中望母归。"
    ]
    var effectLabel :Translucid!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        
       effectLabel = Translucid(frame: CGRect.init(x: 0, y: 64, width: 400, height: 400))
       effectLabel.backgroundColor = UIColor.blue
       //Starjedi   bslr
      /* let path =  Bundle.main.path(forResource: "kabuqinuo", ofType: "otf")
        let font = UIFont.yq_cloudFont(withFilePath: path, size: 30)
       */
       let font = UIFont(name: "REEJI-Cappuccino-LightGB1.0", size: 25)
        //let font = UIFont(name: "Starjedi", size: 20)!
        print("\(font?.fontName)")
        effectLabel.font = font!
        effectLabel.text = "哈哈😝What is 1234567890 ?"
        effectLabel.backgroundImage = UIImage(named: "stars")
        
        self.view.addSubview(effectLabel)
        
        effectLabel.animate()
        
        let btn = UIButton.init()
        btn.setTitle("改动文字", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor.flatBlueDark
        btn.setTitleColor(UIColor.flatWhite, for: .normal)
        btn.addTarget(self, action: #selector(clickBtn(btn:)), for: .touchUpInside)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerX.equalTo(effectLabel)
            make.top.equalTo(effectLabel.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(45)
        }
    }
    var index = 0
    func clickBtn(btn:UIButton)  {
        let count = textArr.count-1
        let oldIndex = index
        while index == oldIndex {
            index = Int(arc4random()%UInt32(count))
        }
        
        let string = textArr[index]
        CATransaction.begin()
        effectLabel.text = string
        CATransaction.commit()
        print("click")
        
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
