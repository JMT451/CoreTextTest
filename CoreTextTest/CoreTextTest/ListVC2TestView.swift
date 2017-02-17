//
//  ListVC2TestView.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/24.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class ListVC2TestView: UIView {
    var image :UIImage?
    let internalLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .redraw;
        self.addSubview(internalLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = bounds.size
        internalLabel.frame = CGRect.init(x: 10, y: size.height-size.width, width: size.width-20, height: size.width-10)
        internalLabel.numberOfLines = 0;
        internalLabel.lineBreakMode = .byCharWrapping
        internalLabel.backgroundColor = UIColor.flatPlum
        internalLabel.textColor = UIColor.flatWhite
        internalLabel.setcornerRadius(value: 8.0)
    }
    let str = " YeyH😁😁🙃"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    
        let mutableAttrStr = NSMutableAttributedString(string: str)
        var callBack = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (obj) in
            
        }, getAscent: { (obj) -> CGFloat in//高度
            return 40
        }, getDescent: { (obj) -> CGFloat in
            return 30
        }) { (obj) -> CGFloat in//宽度
            return 80
        }
        var imgUrl = "http://img3.3lian.com/2013/c2/64/d/65.jpg"
        let callDelegate = CTRunDelegateCreate(&callBack,&imgUrl)
        mutableAttrStr.addAttribute(kCTRunDelegateAttributeName as String, value: callDelegate!, range: NSRange.init(location: 0, length: 1))
         
        // 1 获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 2 转换坐标
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        let path = UIBezierPath(rect: bounds)
//        let path =   UIBezierPath(roundedRect: self.bounds, cornerRadius:self.bounds.size.width/2 )
        UIColor.blue.setStroke()
        path.stroke()
        //
        let frameSetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        let ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path.cgPath, nil)
        CTFrameDraw(ctFrame, context!)
        
        //画图片
        let lines = CTFrameGetLines(ctFrame) as! [CTLine]
        var originArr = [CGPoint].init(repeating: CGPoint.zero, count: lines.count)
        let range = CFRangeMake(0, 0)
        CTFrameGetLineOrigins(ctFrame, range, &originArr)
        //遍历CTRun找出图片所在的CTRun并进行绘制,每一行可能有多个
        for i in 0..<lines.count {
            let line = lines[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
            //            var lineWidth = 0.0
            //            lineWidth =
            CTLineGetTypographicBounds(line , &lineAscent, &lineDescent, &lineLeading)
            let runs = CTLineGetGlyphRuns(line) as Array
            for j in 0..<runs.count {
                // 遍历每一个CTRun
                var  runAscent = CGFloat()
                var  runDescent = CGFloat()
                var  runLeading = CGFloat()
                let  lineOrigin = originArr[i]// 获取该行的初始坐标
                let run = runs[j] // 获取当前的CTRun
                let attributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                let runWidth = CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading)
                let resultString = "\nrunAscent:\(runAscent),\nrunDscent:\(runDescent),\nrunLeading:\(runLeading),\nrunWidth:\(runWidth)\nlineAscent:\(lineAscent),\nlineDescent:\(lineDescent),\nlineLeading:\(lineLeading),\nlineOrigin:\(lineOrigin)"
                print("runAscent:\(runAscent),runDscent:\(runDescent),runLeading:\(runLeading),runWidth:\(runWidth)\n lineAscent:\(lineAscent),lineDescent:\(lineDescent),lineLeading:\(lineLeading),lineOrigin:\(lineOrigin)");
                //CTRunDelegate
                var delegate :Any?
                 delegate = attributes.value(forKey: kCTRunDelegateAttributeName as String)
                
                let runRect = CGRect.init(x: lineOrigin.x+CTLineGetOffsetForStringIndex(line , CTRunGetStringRange(run as!CTRun).location, nil), y: lineOrigin.y-runDescent, width: CGFloat(runWidth), height: runAscent+runDescent)
                let pathRect = UIBezierPath(rect: runRect)
                pathRect.stroke()
             //   return
            if let delegateEntity = delegate{
                    
                let  imgPointer =  CTRunDelegateGetRefCon(delegateEntity as! CTRunDelegate)
               // let urlStr:String = unsafeBitCast(imgPointer, to: String.self);
                
                let urlStr = imgPointer.load(as: String.self)
//                let urlStr = imgUrl.load(as: String.self);
                    var image :UIImage?
                    // #MARK: - ???怎么是高度是70呢？为什么画的是正方形的呢？

                    let imageDrawRect = CGRect.init(x: runRect.origin.x, y: lineOrigin.y-runDescent, width: CGFloat(runWidth), height: CGFloat(runAscent+runDescent))//改成40改成70都行？，结果一样为什么？(只前计算失误，233...)
                
                    if self.image == nil{
                        image = UIImage(named:"hs.jpg") //灰色图片占位
                        //去下载
                        if let url = NSURL.init(string: urlStr ) {
                            let request = NSURLRequest.init(url: url as URL)
                            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                                print("请求完毕")
                                if let data = data{
                                    DispatchQueue.main.async {
                                        self.image = UIImage.init(data: data)
                                        self .setNeedsDisplay()
                                    }
                                }
                            }).resume()
                        }
                    }else{
                        image = self.image
                    }
                    if (image != nil){ context!.draw(image!.cgImage!, in: imageDrawRect)
                    }
                    internalLabel.text = "文字是:\(str)"+"\n"+"结果:"+resultString+"\nimageRect:\(imageDrawRect)"

                }
                }
            }
        
        
        
    }
    

}
