//
//  TextKitVC3.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/9.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit
import ChameleonFramework
class TextKitVC3: UIViewController {
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        btn1.snp.makeConstraints { (make) in
            make.center.equalTo(view.center)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        btn2.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(btn1.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        btn3.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(120)
            make.height.equalTo(40)
            make.top.equalTo(btn2.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        btn1.setcornerRadius(value: 5.0)
        btn2.setcornerRadius(value: 5.0)
        btn3.setcornerRadius(value: 5.0)
        //btn1
        btn1.addTarget(self, action: #selector(btn1Action), for: .touchUpInside)
        btn1.setTitle("文本布局", for: .normal)
        btn1.setTitleColor(UIColor.flatWhite, for: .normal)
        btn1.backgroundColor = UIColor.flatBlue
        //btn2
        btn2.addTarget(self, action: #selector(btn2Action), for: .touchUpInside)
        btn2.setTitle("文本动画", for: .normal)
        btn2.backgroundColor = UIColor.flatBlue
        btn2.setTitleColor(UIColor.flatWhite, for: .normal)
        //btn3
        btn3.addTarget(self, action: #selector(btn3Action), for: .touchUpInside)
        btn3.setTitle("TextLayerLabel", for: .normal)
        btn3.backgroundColor = UIColor.flatBlue
        btn3.setTitleColor(UIColor.flatWhite, for: .normal)
        
        var totalString = ""
        let hearts = "Hea💘rts <3 ♥︎ 💘"
        totalString.append(hearts)
        if let i = hearts.characters.index(of: " ") {
            var utf8Str = ""
            for code  in hearts.utf16 {
                utf8Str.append(" \(code)")
            }
            totalString.append("\n\nutf8 codes:"+utf8Str)

            let j = i.samePosition(in: hearts.utf8)
            let temp1 = Array(hearts.utf8.prefix(upTo: j)).description
            totalString.append("\n\n Sub_utf8Code_Arr:"+temp1)

            
            var utf16Str = ""
            for code  in hearts.utf16 {
                utf16Str.append(" \(code)")
            }
            totalString.append("\n\nutf16 codes:"+utf16Str)
            let k = i.samePosition(in: hearts.utf16)
            let temp2 = Array(hearts.utf16.prefix(upTo: k)).description
            totalString.append("\n\n Sub_utf16Code_Arr:"+temp2)
            print(hearts.utf8.prefix(upTo: j))
        }
        let textView = UITextView()
        view.addSubview(textView)
        textView.backgroundColor = UIColor.flatBlack
        textView.textColor = UIColor.flatWhite
        textView.text = totalString
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(btn1.snp.top).offset(-20)
        }
        
    }
    func btn1Action()  {
        let vc = TKSLayoutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func btn2Action() {
        let vc = TextEffetcVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func btn3Action()  {
        let vc = RootViewController()
        self.navigationController?.pushViewController(vc, animated: true)

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
