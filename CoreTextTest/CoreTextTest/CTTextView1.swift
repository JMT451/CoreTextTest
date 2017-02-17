//
//  CTTextView1.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/21.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class CTTextView1: UIView {
    var image :UIImage?
    override func draw(_ rect: CGRect) {
    //1.获取上下文
        let context = UIGraphicsGetCurrentContext()
    //2.转换坐标系
        context!.textMatrix = CGAffineTransform.identity
        // #MARK: - ???  不清楚为什么是这样去变换，API作用不清楚
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
    //3.绘制区域
       /* let path = CGMutablePath()
        path.addRect(self.bounds)*/
        let path1 = UIBezierPath(roundedRect: self.bounds, cornerRadius:self.bounds.size.width/2 )
        UIColor.red.setStroke()
        path1.stroke()
        
    //4.绘制的字体
        let string = "Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreTexty!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!"
        let attrString = NSMutableAttributedString(string:string)
        attrString.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 30),NSForegroundColorAttributeName:UIColor.red], range: NSRange.init(location: 0, length: 21))
        attrString.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13),NSUnderlineStyleAttributeName: 1 ], range: NSMakeRange(30,58))
                //设置段落样式
        let style = NSMutableParagraphStyle()   //用来设置段落样式
        style.lineSpacing = 6 //行间距
        attrString.addAttributes([NSParagraphStyleAttributeName:style], range: NSMakeRange(0, attrString.length))
    //5.为图片预留空间

        var callBack = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (refCon) in
            
        }, getAscent: { (refCon) -> CGFloat in //height
            return 50
        }, getDescent: { (refCon) -> CGFloat in 
            return 20
        }) { (refCon) -> CGFloat in //width
            return 50
        }
        //本地图片
        var imageName = "mc.jpg"
        let runDelegate = CTRunDelegateCreate(&callBack, &imageName)
        let imgString = NSMutableAttributedString(string: " ")  // 空格用于给图片留位置
        imgString.addAttributes([kCTRunDelegateAttributeName as String:runDelegate!], range: NSMakeRange(0, 1))
        imgString.addAttribute("imageName", value: imageName, range: NSMakeRange(0, 1))//添加属性，在CTRun中可以识别出这个字符是图片
        attrString.insert(imgString, at: 15)
        var imageUrl = "http://img3.3lian.com/2013/c2/64/d/65.jpg" //网络图片链接
        let urlRunDelegate  = CTRunDelegateCreate(&callBack, &imageUrl)

        //网络图片
        let imgUrlString = NSMutableAttributedString(string: " ")  // 空格用于给图片留位置
        imgUrlString.addAttribute(kCTRunDelegateAttributeName as String, value: urlRunDelegate!, range: NSMakeRange(0, 1))  //rundelegate  占一个位置
        imgUrlString.addAttribute("urlImageName", value: imageUrl, range: NSMakeRange(0, 1))//添加属性，在CTRun中可以识别出这个字符是图片
        attrString.insert(imgUrlString, at: 50)
        
    //6. 生成framesetter
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path1.cgPath, nil)
    //7. 绘制除图片以外的部分
        CTFrameDraw(frame,context!)
    //8.处理绘制图片逻辑
        let lines = CTFrameGetLines(frame)
        let ctLinesArray = lines as Array
        var originsArray = [CGPoint].init(repeating: CGPoint.zero, count: ctLinesArray.count)
        let range = CFRangeMake(0, 0)
        CTFrameGetLineOrigins(frame, range, &originsArray)
        //遍历CTRun找出图片所在的CTRun并进行绘制,每一行可能有多个
        for i in 0..<originsArray.count {
            let line = ctLinesArray[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
//            var lineWidth = 0.0
//            lineWidth =
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            let runs = CTLineGetGlyphRuns(line as! CTLine) as Array
            for j in 0..<runs.count {
                // 遍历每一个CTRun
                var  runAscent = CGFloat()
                var  runDescent = CGFloat()
                var  runLeading = CGFloat()
                let  lineOrigin = originsArray[i]// 获取该行的初始坐标
                let run = runs[j] // 获取当前的CTRun
                let attributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                let runWidth = CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading)
                // #MARK: - ??? y是什么？ x怎么计算的？
                let runRect = CGRect.init(x: lineOrigin.x+CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as!CTRun).location, nil), y: lineOrigin.y-runDescent, width: CGFloat(runWidth), height: runAscent+runDescent)
                let imageName = attributes.value(forKey: "imageName")
                let urlImageName = attributes.value(forKey: "urlImageName")
                // #MARK: - ??? 不清楚 String 和NSString的区别，swift和oC数据结构的共性和差别？
                let imageDrawRect = CGRect.init(x: runRect.origin.x, y: lineOrigin.y-runDescent, width: 50, height: 50 )
                if  imageName is NSString {//本地图片
                    let image = UIImage.init(named: imageName as! String)
                    context!.draw((image?.cgImage)!, in: imageDrawRect)
                    print("runAscent:\(runAscent),runDscent:\(runDescent),runLeading:\(runLeading),runWidth:\(runWidth)\n lineAscent:\(lineAscent),lineDescent:\(lineDescent),lineLeading:\(lineLeading)");
                }
                if urlImageName is NSString{//网络图片
                    var image :UIImage?
                    let imageDrawRect = CGRect.init(x: runRect.origin.x, y: lineOrigin.y, width: 50, height: 50 )
                    if self.image == nil{
                        image = UIImage(named:"hs.jpg") //灰色图片占位
                        //去下载
                        if let url = NSURL.init(string: urlImageName as! String) {
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
                 if (image != nil){ context!.draw(image!.cgImage!, in: imageDrawRect)}
                }
            }
        }
        //试一下path的问题
        let roundPath1 = UIBezierPath(ovalIn: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        let roundPath2 = UIBezierPath(ovalIn: CGRect.init(x: 0, y: 50, width: 100, height: 100))
        roundPath1.append(roundPath2)
        UIColor.yellow.setStroke()
        roundPath1.fill()
        roundPath1.stroke()
       }
}
