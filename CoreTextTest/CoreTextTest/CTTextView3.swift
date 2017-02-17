//
//  CTTextView3.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/1/23.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class CTTextView3: UIView,UIGestureRecognizerDelegate {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var totalHeight:CGFloat {
        get{
            return sizeForText(mutableStr: NSMutableAttributedString(string: attrString)).height
        }
    }
    var totalHeight2:CGFloat = 0.0
    var sepcialRanges:[NSRange]!
    var pressRange:NSRange?
    var ctFrame :CTFrame?
    let attrString = "111来一段数 @sd圣诞节 字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl http://www.baidu.com 是电话费卡刷卡来这来一段数字,文本emoji http://www.zuber.im 的哈哈哈29993002-309-sdflslsfl是电话费卡 @kakakkak 刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这&&&"
    var lineHeight:CGFloat!
    override func draw(_ rect: CGRect) {
        // 1 获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 2 转换坐标
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        // 3 绘制区域
        // #MARK: - ??? 替换了下面的path你就会发现这篇的计算高度的方式不对！

        let path = UIBezierPath(rect: rect)
//      let path =   UIBezierPath(roundedRect: self.bounds, cornerRadius:self.bounds.size.width/2 )
        UIColor.red.setStroke()
        path.stroke()

        // 4 创建需要绘制的文字
//        let attrString = "来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这"
        
        // 5 设置frame
        let mutableAttrStr = NSMutableAttributedString(string: attrString)
        self.sepcialRanges = recognizeSpecialString(attrStr: mutableAttrStr)
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttrStr.length), path.cgPath, nil)
        
        // 6 取出CTLine 准备一行一行绘制
        let lines = CTFrameGetLines(ctFrame!)
        let lineCount = CFArrayGetCount(lines)
       
        var lineOrigins:[CGPoint] = Array.init(repeating: CGPoint.zero, count: lineCount)
        //把frame中的每一行的初始坐标写到数组里，注意CoreText的坐标左下角为原点
        CTFrameGetLineOrigins(ctFrame!, CFRange.init(location: 0, length: 0), &lineOrigins)
        // #MARK: - ？？？ 疑问 这个size难道和path没有关系吗？
        //获取属性字所占的size
       let size = sizeForText(mutableStr: mutableAttrStr)
       let height = size.height
       
       let font = UIFont.systemFont(ofSize: 14)
       var frameY:CGFloat = 0
       //计算每行的高度(总高度除以行数)
       lineHeight = height/CGFloat(lineCount)
      
  
       for i in 0..<lineCount{
            let lineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            var lineAscent:CGFloat = 0
            var lineDescebnt:CGFloat = 0
            var lineLeading :CGFloat = 0
            //
            CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescebnt, &lineLeading)
        
            var lineOrigin = lineOrigins[i]
            //计算那y值
        // #MARK: - ？？？ 一直不明白这个计算方式
            frameY = height - CGFloat(i+1)*lineHeight-font.descender
            //设置y值
            lineOrigin.y = frameY
        
            //绘制
            context!.textPosition = lineOrigin
            CTLineDraw(lineRef, context!)
            //调整坐标
            frameY = frameY - lineDescebnt
//        print(" lineAscent:\(lineAscent),lineDescent:\(lineDescebnt),lineLeading:\(lineLeading),frameY :\(frameY)");
            if i == lineCount-1 {
                totalHeight2 = frameY
            }
        }
        
        
    }
    // #MARK: - 专门计算size的CTFrame方法
    func caculateSize(){
        let path = UIBezierPath(rect: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        //      let path =   UIBezierPath(roundedRect: self.bounds, cornerRadius:self.bounds.size.width/2 )
        UIColor.red.setStroke()
        path.stroke()
        
        // 5 设置frame
        let mutableAttrStr = NSMutableAttributedString(string: attrString)
        self.sepcialRanges = recognizeSpecialString(attrStr: mutableAttrStr)
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttrStr.length), path.cgPath, nil)
        
        // 6 取出CTLine 准备一行一行绘制
        let lines = CTFrameGetLines(ctFrame!)
        let lineCount = CFArrayGetCount(lines)
        
        var lineOrigins:[CGPoint] = Array.init(repeating: CGPoint.zero, count: lineCount)
        //把frame中的每一行的初始坐标写到数组里，注意CoreText的坐标左下角为原点
        CTFrameGetLineOrigins(ctFrame!, CFRange.init(location: 0, length: 0), &lineOrigins)
        // #MARK: - ？？？ 疑问 这个size难道和path没有关系吗？
        //获取属性字所占的size
        let size = sizeForText(mutableStr: mutableAttrStr)
        let height = size.height
        
        let font = UIFont.systemFont(ofSize: 14)
        var frameY:CGFloat = 0
        //计算每行的高度(总高度除以行数)
        lineHeight = height/CGFloat(lineCount)
        
        
        for i in 0..<lineCount{
            let lineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            var lineAscent:CGFloat = 0
            var lineDescebnt:CGFloat = 0
            var lineLeading :CGFloat = 0
            //
            CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescebnt, &lineLeading)
            
            var lineOrigin = lineOrigins[i]
            //计算那y值
            // #MARK: - ？？？ 一直不明白这个计算方式
            frameY = height - CGFloat(i+1)*lineHeight-font.descender
            //设置y值
            lineOrigin.y = frameY
            
       
            //调整坐标
            frameY = frameY - lineDescebnt
            print(" lineAscent:\(lineAscent),lineDescent:\(lineDescebnt),lineLeading:\(lineLeading),frameY :\(frameY)");
            if i == lineCount-1 {
                totalHeight2 = frameY
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

    // #MARK: - 链接 和人名
    //url的正则
    let regex_url = "(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&:/~\\+#]*[\\w\\-\\@?^=%&/~\\+#])?"
    
    let regex_someone = "@[^\\s@]+?\\s{1}"
    func recognizeSpecialString(attrStr:NSMutableAttributedString) -> [NSRange] {
        var rangeArr = [NSRange]()
        //识别人名
        let atRegular = try?NSRegularExpression(pattern: regex_someone, options: .caseInsensitive)
        let atResults = atRegular?.matches(in: attrStr.string, options: .withTransparentBounds, range: NSRange(location: 0, length: attrStr.length))
        for checkResult in atResults! {
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange.init(location: checkResult.range.location, length: checkResult.range.length))
            rangeArr.append(checkResult.range)
        }
        //识别链接
        let urlRegular = try?NSRegularExpression(pattern: regex_url, options: .caseInsensitive)
        let urlResults = urlRegular?.matches(in: attrStr.string, options: .withTransparentBounds, range: NSRange.init(location: 0, length: attrStr.length))
        for checkResult in urlResults!{
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(checkResult.range.location, checkResult.range.length))
            rangeArr.append(checkResult.range)
        }
        return rangeArr
    }
    var tap:UITapGestureRecognizer!
    override init(frame: CGRect) {
    super.init(frame: frame)
        //添加手势
         tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(gesture:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    // #MARK: - ??? 这个是必须的，当我重写init。frame这个方法的时候，它提示

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tapAction(gesture:UITapGestureRecognizer)  {
        switch gesture.state {
        case .ended:
            let nsStr = self.attrString as NSString
            if let range = self.pressRange {
                let pressStr = nsStr.substring(with: range)
                print(pressStr)
            }
            
         default:
            print("error")
        }
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(self.tap) {
        //点击处在特定字符串内才进行识别
        var gestureShouldBegin = false
        let location = gestureRecognizer.location(in: self)
        let lineIndex = Int(location.y/lineHeight)
        
        print("你点击了第\(lineIndex)行")
        //把点击坐标转化成CoreText坐标系下
        let clickPoint = CGPoint.init(x: location.x, y: lineHeight-location.y)
        let lines = CTFrameGetLines(self.ctFrame!);
        let lineCount = CFArrayGetCount(lines as CFArray!)
        if lineIndex < lineCount{
            let lines = lines as! [CTLine]
            let clickLine = lines[lineIndex]
            //点击的位置的index
            let startIndex = CTLineGetStringIndexForPosition(clickLine, clickPoint)
            print("strIndex = \(startIndex)")
            for range in self.sepcialRanges{
                if startIndex >= range.location && startIndex <= range.location+range.length {
                    gestureShouldBegin = true
                    self.pressRange = range

                }
            
            }
        }   
            return gestureShouldBegin
        }else{
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
    }
    override func layoutSubviews() {
//        self.setNeedsDisplay()
    }
}
