//
//  ListVC4.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/14.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class ListVC4: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var sources = [NSString]()
    @IBOutlet weak var drawView: FontDrawPathView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sources = UIFont.familyNames as [NSString]
        let string:NSString = "123456"
        let font = UIFont.init(name: "Gujarati Sangam MN", size: 12.0)
        let attStr = NSMutableAttributedString(string:string as String)
        
        attStr.addAttributes([NSFontAttributeName:font ?? UIFont.systemFont(ofSize: 12.0)], range: NSRange.init(location: 0, length: string.length))

        //drawView.showAnimateType = .animatedPath_type
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textView: UITextView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            drawView.showAnimateType = .default_type
        case 1:
            drawView.showAnimateType = .animatedPath_type
        case 2:
            //slider.value = 0
            drawView.showAnimateType = .progress_type
        default:break
        
        }
        // #MARK: - ？？？

      /*  DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(0.1))) {//很明显，这是由于动画加入的时机问题，动画的加入并不是直接加入的，很可能是异步加入或者其他线程执行导致计算添加动画的起始时间计算也一并算入了（如果不加延迟的话）
            self.updateSliderValue(sender: self.slider),本来以为view重新添加了导致只能延迟才能让动画子先计算时间，发现是自己看错了，只要是异步都行。问题是：时零时不灵！！！
        }*/
        DispatchQueue.main.async {//注意，异步就好！
            self.updateSliderValue(sender: self.slider)
        }
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        updateSliderValue(sender: sender)
    }
    func updateSliderValue(sender:UISlider)  {
        drawView .updatePathStrokeWithValue(sender.value)
    }
    @IBAction func changeText(_ sender: UIButton) {
        drawView.textToAnimate = textView.text
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
   
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return sources.count
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?{
            let title = sources[row]
            let attStr = NSMutableAttributedString(string: title as String )
            let font = UIFont.init(name: title as String , size: 20)
        if let font = font {
            attStr.addAttributes([NSFontAttributeName:font], range: NSRange.init(location: 0, length: title.length))
        }
        return attStr
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = sources[row]
        let font = UIFont.init(name: title as String, size: 30)
        drawView.fontName = title as String
//        let font = UIFont.init(name: "Apple Color Emoji", size: 12.0)
//        let attStr = NSMutableAttributedString(string:textView.text)
        
//            attStr.addAttributes([NSFontAttributeName:font ?? UIFont.systemFont(ofSize: 12.0)], range: NSRange.init(location: 0, length: title.length))
        drawView.reloadText()
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
