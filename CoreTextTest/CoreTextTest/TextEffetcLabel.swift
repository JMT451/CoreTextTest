//
//  TextEffetcLabel.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/9.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit
typealias textAnimationClosure = ()->()
class TextEffetcLabel: UILabel,NSLayoutManagerDelegate {

    let textStorage = NSTextStorage(string: "")
    let textContainer = NSTextContainer()
    let layoutManager = NSLayoutManager()
    
    var oldCharacterLayers:[CATextLayer] = []
    var newCharacterLayers:[CATextLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextSystem()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTextSystem()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTextSystem()
    }
    func prepareTextSystem()  {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        layoutManager.delegate = self
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
    }
    override var numberOfLines: Int{
        get{
          return   super.numberOfLines
        }
        set{
            textContainer.maximumNumberOfLines = newValue
            super.numberOfLines = newValue
        }
    }
    override var lineBreakMode: NSLineBreakMode{
        get{
          return  super.lineBreakMode
        }
        set{
            textContainer.lineBreakMode = newValue
            super.lineBreakMode = newValue
        }
    }
    override var bounds: CGRect{
        get{
            return super.bounds
        }
        set{
            textContainer.size = newValue.size
            super.bounds = newValue
        }
    }
    
    override var text: String!{
        get{
            return textStorage.string
        }
        
        set{
            super.text = ""
            let attributedText = NSMutableAttributedString(string: newValue)
            let textRange = NSMakeRange(0, newValue.characters.count)
            attributedText.setAttributes([NSForegroundColorAttributeName:self.textColor], range: textRange)
            attributedText.setAttributes([NSFontAttributeName:self.font], range: textRange)
            let paragraphyStyle = NSMutableParagraphStyle()
            paragraphyStyle.alignment = self.textAlignment
            attributedText.addAttributes([NSParagraphStyleAttributeName:paragraphyStyle], range: textRange)
            self.attributedText = attributedText
         
        }
    }
    override var attributedText: NSAttributedString!{
        get {
            return textStorage as NSAttributedString
        }
        set{
            cleanOldCharacterTextLayers()

            oldCharacterLayers = Array(newCharacterLayers)
            textStorage.setAttributedString(newValue)
            startAnimation(completeBlock: nil)
            endAnimation(nil)
        }
    }
    override var textAlignment: NSTextAlignment{
        didSet{
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var firstCharPath :UIBezierPath?
    var lineUsedRectPath:UIBezierPath?
    var baseLinePath : UIBezierPath?
}
extension TextEffetcLabel{
    func cleanOldCharacterTextLayers()  {
        for layer  in oldCharacterLayers {
            layer.removeFromSuperlayer()
        }
        oldCharacterLayers.removeAll()
        oldCharacterLayers = newCharacterLayers
    }
    func caculateLayerPosistion()  {
        newCharacterLayers.removeAll()
        let charRange = NSRange.init(location: 0, length:textStorage.length)
//        let layoutRect = layoutManager.usedRect(for: textContainer)
        var index = charRange.location
        let totalLengh = NSMaxRange(charRange)
        
        
        while index<totalLengh {
            if totalLengh>2 && index == totalLengh - 2 {
                
            }
            let glyphRange = NSRange.init(location: index, length: 1)
            var actualGlyphRange = NSRange()
            let characterRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: &actualGlyphRange)
            var actualCharacterRange = NSRange()
            let reverseGlyphRange = layoutManager.glyphRange(forCharacterRange: characterRange, actualCharacterRange: &actualCharacterRange)
            let textContainer = layoutManager.textContainer(forGlyphAt: index, effectiveRange: nil)
            if actualCharacterRange.length != 0 {
                
            }
            let glyphRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer!)
       
            let glyphPosition = layoutManager.location(forGlyphAt: index)
            let lineUsedRect = layoutManager.lineFragmentUsedRect(forGlyphAt: index, effectiveRange: nil)
            let pointY = lineUsedRect.origin.y + glyphPosition.y
            let subString = textStorage.attributedSubstring(from: characterRange)
            if index == 0 {
                
            //    let extralLineFragmentRect = layoutManager.extraLineFragmentRect
              //  let extralLineUsedRect = layoutManager.extraLineFragmentUsedRect
                var effectCharRange = NSRange()
                let attribues = subString.attributes(at: 0, effectiveRange: &effectCharRange)
                
                let font = attribues[NSFontAttributeName]
                var glyphBelowHeight :CGFloat?
                if  let unWrapFont = font as? UIFont {
                    //     let width = unWrapFont.
                    glyphBelowHeight = unWrapFont.capHeight
                    print("ascender:\(unWrapFont.ascender),\n,descender:\(unWrapFont.descender),\n,leading:\(unWrapFont.leading)\n,capHeight:\(unWrapFont.capHeight),\n,pointSize:\(unWrapFont.pointSize),\n,xHeight:\(unWrapFont.xHeight),\n,capHeight:\(unWrapFont.capHeight)\n,lineHeight:\(unWrapFont.lineHeight)")
                }
                var glyPhRectCopy = glyphRect
                if let ascender = glyphBelowHeight {
                    glyPhRectCopy.origin.y += pointY - ascender
                }
                firstCharPath = UIBezierPath(rect: glyphRect)//第一个字符
                // firstCharPath = UIBezierPath(rect: glyPhRectCopy)//第一个字符真正绘制的区域,按照这个计算的也不对的，对于H Y还对，但是对于e y 就不对了
                

                lineUsedRectPath = UIBezierPath(rect: lineUsedRect)//整行
                baseLinePath = UIBezierPath()//Baseline
                baseLinePath?.move(to: CGPoint.init(x: 0, y: pointY))
                baseLinePath?.addLine(to: CGPoint.init(x: Screen_W, y: pointY))
                setNeedsDisplay()
            }
            // #MARK: - ???一会儿设置一下代理再说！
            //363.96
        
            
    
           // let kerningRange = layoutManager.range(ofNominallySpacedGlyphsContaining: index)
            print("glyphRange:\(glyphRange.location),\(glyphRange.length) ,characterRange:\(characterRange.location),\(characterRange.length) ,actualGlyphRange:\(actualGlyphRange.location),\(actualGlyphRange.length)")
            // #MARK: - 1.想要解决

          //这个目前猜测是...那部分  let rangeeee = layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: index)
//    这个方法很明显不对的        if kerningRange.location == index && kerningRange.length > 1 {
         
          //  if characterRange.length != glyphRange.length {//没用的。kerning也是不对的
                if newCharacterLayers.count > 0 {
                    let previoursLayer = newCharacterLayers[newCharacterLayers.endIndex-1]
                    var frame = previoursLayer.frame
                   // frame.size.width += glyphaRect.maxX - frame.maxX //这个计算是有问题的，裁剪的是一小部分，不如我们添加一点点宽度
                   frame.size.width += 10
                    previoursLayer.frame = frame
                }
                
         //   }
          //  glyphaRect.origin.y += self.bounds.size.height/2 - layoutRect.size.height/2
            let textLayer = CATextLayer(frame: glyphRect, string:(subString))
            initialTerxtLayer(layer: textLayer)
            self.layer.addSublayer(textLayer)
            newCharacterLayers.append(textLayer)
            index += characterRange.length
        }
    }
    // #MARK: - layoutManagerDelegate
    func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        caculateLayerPosistion()
    }
    func initialTerxtLayer (layer:CATextLayer)  {
        layer.opacity = 0
    }
    override func draw(_ rect: CGRect) {
        if let path = firstCharPath {
            path.stroke()
        }
        if let path = lineUsedRectPath {
            path.stroke()
        }
        if let path = baseLinePath{
            path.stroke()
        }
    }
}
extension TextEffetcLabel{
    func startAnimation(completeBlock:textAnimationClosure?)  {
        var longestAnimationDuration = 0.0
        var longestAniamtionIndex = -1
        var index = 0
        for textlayer in oldCharacterLayers
        {
            
            //            let duration = NSTimeInterval(arc4random()%200/100)+0.25
            let duration = (TimeInterval(arc4random()%100)/125.0)+0.35
            
            let delay = TimeInterval(arc4random_uniform(100)/500)
            let distance = CGFloat(arc4random()%50)+25
            let angle = CGFloat((Double(arc4random())/M_PI_2)-M_PI_4)
            var transform = CATransform3DMakeTranslation(0, distance, 0)
            transform = CATransform3DRotate(transform, angle, 0, 0, 1)
            if delay+duration > longestAnimationDuration
            {
                longestAnimationDuration = delay+duration
                longestAniamtionIndex = index
            }
           TELayerAniamtion.textLayerAnimation(textlayer, durationTime: duration, delayTime: delay, animationClosure: { (layer) -> CALayer in
                layer.transform = transform
                layer.opacity = 0
                return layer
            }, completion: { (flag) in
                textlayer.removeFromSuperlayer()
                if self.oldCharacterLayers.count > longestAniamtionIndex  && textlayer == self.oldCharacterLayers[longestAniamtionIndex]
                {
                    if let animationOut = completeBlock
                    {
                        animationOut()
                    }
                }
            
           })
            
            index += 1
      }
    }
    func endAnimation(_ animationClosure:textAnimationClosure?)
    {
        
        
        for textLayer in newCharacterLayers
        {
            //            textLayer.opacity = 0.0
            let duration = TimeInterval(arc4random()%200/100)+0.25
            let delay = 0.06//NSTimeInterval(arc4random_uniform(100)/500)
            
            TELayerAniamtion.textLayerAnimation(textLayer, durationTime: duration, delayTime: delay, animationClosure: { (layer) -> CALayer in
                layer.opacity = 1.0
                return layer
            }, completion: { (finished) -> () in
                if let animationIn = animationClosure {
                    animationIn()
                }
                
            })
        }
        
    }

}
extension CATextLayer {
    convenience init(frame:CGRect,string:NSAttributedString ) {
        self.init()
        self.contentsScale = UIScreen.main.scale
        self.string = string
        self.frame = frame
    }
}
