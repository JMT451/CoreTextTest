//
//  CTTextView2.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/23.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class CTTextView2: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    let attrString = "来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这&&&END"

    override func draw(_ rect: CGRect) {
        // 1 获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 2 转换坐标
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        // 3 绘制区域
//        let path = UIBezierPath(rect: rect)
//        let path = UIBezierPath(arcCenter: CGPoint.init(x: rect.size.width/2, y: 0), radius: rect.size.width/2, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        var transfrom = CGAffineTransform(translationX: 0, y: self.bounds.size.height)
        transfrom = transfrom.scaledBy(x: 1, y: -1)
      /*  let path = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        let path2 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 50, width: 100, height: 100))
        path2.apply(transfrom)
        path.append(path2)*/
        let path = UIBezierPath()
        let spePath = speBeziPath(widht: rect.width, height: rect.height)
        spePath.apply(transfrom)
        let path2 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 50, width: 100, height: 100))
        path2.apply(transfrom)
        path.append(spePath)
        path.append(path2)
        let path3 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 100, width: 120, height: 120))
        path3.apply(transfrom)
        path.append(path3)
        UIColor.blue.setStroke()
        path.stroke()
        //画条线看看坐标系是不是左下角(结果证明确实是上面将坐标系转换了的原因导致坐标系原点在左下了。如果不转化的话，CoreText绘制的是反的)
        context?.move(to: CGPoint.init(x: 0, y: 20))
        context?.addLine(to: CGPoint.init(x: Screen_W, y: 20))
        context?.strokePath()
//        path.append(leftPath)
        
        // 4 创建需要绘制的文字
        
        // 5 设置frame
        let mutableAttrStr = NSMutableAttributedString(string: attrString)
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttrStr.length), path.cgPath, nil)
        // 6 绘制
        CTFrameDraw(frame, context!)
        
        
    }
    var totolHeight:CGFloat{
        return sizeForText(mutableStr: NSMutableAttributedString.init(string: attrString)).height
    }
    enum compareHeight {
        case None
        case Bigger
        case Litte
    }
    var resultHeight:CGFloat = 0.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        resultHeight = getHeight(height: totolHeight+200, compareIdenti: .None)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var getHeightCount:Int =  0
    func getHeight(height:CGFloat, compareIdenti:compareHeight = .None) -> CGFloat {
        print("调用了\(getHeightCount+1)次")
        getHeightCount = getHeightCount + 1
        let widht = Screen_W-20
        let rect = CGRect.init(x: 0, y: 0, width: Screen_W-20, height:height)
        var transfrom = CGAffineTransform(translationX: 0, y: height)
        transfrom = transfrom.scaledBy(x: 1, y: -1)
        let path = UIBezierPath()
        let spePath = speBeziPath(widht: widht, height: height)
        spePath.apply(transfrom)
        path.append(spePath)
        let path2 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 50, width: 100, height: 100))
        path2.apply(transfrom)
        path.append(path2)
        let path3 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 100, width: 120, height: 120))
        path3.apply(transfrom)
        path.append(path3)
      /*  let path = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        let path2 = UIBezierPath(ovalIn: CGRect.init(x: 50, y: 50, width: 100, height: 100))
        path2.apply(transfrom)
        path.append(path2)*/
        let mutableAttrStr = NSMutableAttributedString(string: attrString)
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttrStr.length), path.cgPath, nil)
        let lines = CTFrameGetLines(frame) as Array
        let lineCount = lines.count
        let lastLine = lines.last as! CTLine
        var lineAscent:CGFloat = 0.0
        var lineDescent :CGFloat = 0.0
        var lineLeading :CGFloat = 0.0
        CTLineGetTypographicBounds(lastLine, &lineAscent,&lineDescent, &lineLeading)
        var lineOrigins = [CGPoint].init(repeating: CGPoint.zero, count: lineCount)
        // #MARK: - ???重要的是 如果没有设置range的话，那么得到的不是所有的lines的orgin，如果设置是全部的话，但是如果frame的高度不够的话还是不会算出所有的origin，值得注意一下！
        //不清楚为什么设置string的range的时候，获取到的lastOrigin一直不变，
        //lines数组不是所有的数组，而是能容得下的数组，但是lines的orgins获得的却不是哦！
        let boxRect = CTFrameGetPath(frame).boundingBox;
        CTFrameGetLineOrigins(frame, CFRangeMake(0,0), &lineOrigins)
        let lastOrigin = lineOrigins.last
        let lastY = lastOrigin!.y-lineDescent-lineLeading
        let resultHeight = height - lastY
        
//        return resultHeight    //这一种是给定了一个固定的无限大边框的话是可以的，但是如果边框和高度也有关的话只能用下面的方法了
        
        
//通过判断最后的line的最后一个位置是不是string的最后一个位置来计算高度
        let lastRuns = CTLineGetGlyphRuns(lastLine) as! Array<CTRun>
        let lastRun = lastRuns.last
        let lastRunRange =   CTRunGetStringRange(lastRun!)
        //比较lastRunRange.location+lastRunRange.length的location和length的大小
        if lastRunRange.location+lastRunRange.length>=mutableAttrStr.length {//height超了或者刚好
            if compareIdenti == .Litte {
                return height
            }else{
                return getHeight(height: height-5, compareIdenti: .Bigger)
            }
        }else{//height 不够
            if compareIdenti == .Bigger {
                return height+5
            }else{
                return getHeight(height: height+5,compareIdenti: .Litte)
            }
        }
        
        
        //对比最终的结果和之前输入的结果 
        print("lastOrigtinY:\(lastOrigin?.y),lineAscent:\(lineAscent),lineDescent:\(lineDescent),lineLeading:\(lineLeading),lineCount:\(lineCount)")
        if resultHeight>height {//给定的高度比实际的少
            if compareIdenti == .Bigger {
                return height+5
            }else{
                return getHeight(height: height+5,compareIdenti: .Litte)
            }
        }else{//给定的高度比实际的大
            if compareIdenti == .Litte {
                return height
            }else {
            return getHeight(height: height-5,compareIdenti: .Bigger)
            }
        }
        
    }
    func sizeForText(mutableStr:NSMutableAttributedString) -> CGSize {
        //创建CTFramesetterRef实例
        let frameSetter = CTFramesetterCreateWithAttributedString(mutableStr)
        
        //获得要绘制区域的高度
        let restricSize = CGSize.init(width: Screen_W-20, height: CGFloat.greatestFiniteMagnitude)
        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRange.init(location: 0, length: 0), nil, restricSize, nil)
        return coreTextSize
        
    }
    func convertP(point:CGPoint,width:CGFloat,height:CGFloat) -> CGPoint {
        // #MARK: - !!! 很有意思的一点技巧
//    240 160(OR 150)
        return CGPoint.init(x: width * point.x/240, y: height * point.y/150)
    }
    func speBeziPath(widht:CGFloat,height:CGFloat) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: convertP(point: CGPoint.init(x: 58.5, y: 30.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 164.5, y: 30.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 58.5, y: 30.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 133.5, y: -3.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 190.5, y: 8.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 195.5, y: 64.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 190.5, y: 8.5), width: widht, height: height))
        bezierPath.addLine(to: convertP(point: CGPoint.init(x: 229.5, y: 8.5), width: widht, height: height))
        bezierPath.addLine(to: convertP(point: CGPoint.init(x: 229.5, y: 112.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 33.5, y: 112.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 229.5, y: 112.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 41.5, y: 194.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 14.5, y: 86.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 25.5, y:30.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 14.5, y: 86.5), width: widht, height: height))
        bezierPath.addLine(to: convertP(point: CGPoint.init(x: 14.5, y: 13.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 52.5, y: 13.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 14.5, y:13.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 46.5, y: -3.5), width: widht, height: height))
        bezierPath.addCurve(to:convertP(point: CGPoint.init(x: 58.5, y: 30.5), width: widht, height: height), controlPoint1: convertP(point: CGPoint.init(x: 58.5, y:30.5), width: widht, height: height), controlPoint2:  convertP(point: CGPoint.init(x: 58.5, y: 30.5), width: widht, height: height))
        
        bezierPath.lineWidth = 1
        return bezierPath
    }
}
