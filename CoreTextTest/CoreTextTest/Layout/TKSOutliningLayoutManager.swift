//
//  TKSOutliningLayoutManager.swift
//  TextKitStudy
//
//  Created by steven on 2/17/16.
//  Copyright © 2016 Steven lv. All rights reserved.
//

import UIKit

class TKSOutliningLayoutManager: NSLayoutManager {
    
    var count:Int = 0;
    
    override func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)
    }
    
    override func drawUnderline(forGlyphRange glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
       // super.drawUnderline(forGlyphRange: glyphRange, underlineType: underlineVal, baselineOffset: baselineOffset, lineFragmentRect: lineRect, lineFragmentGlyphRange: lineGlyphRange, containerOrigin: containerOrigin)
        if underlineVal.rawValue & CustomUnderlineStyle == CustomUnderlineStyle {
            let charRange = self.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            if let underlineColor = textStorage?.attribute(NSUnderlineColorAttributeName, at: charRange.location, effectiveRange: nil) as? UIColor {
                underlineColor.setStroke()
            }
            
            if let container = textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil) {
                let boundingRect = self.boundingRect(forGlyphRange: glyphRange, in: container)
                let offsetRect = boundingRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y)
                let rectPath = UIBezierPath.init(rect: offsetRect)
                rectPath.stroke()
                drawFancyUnderlineForRect(offsetRect)
                //画一个红色的usedRect
                var usedRect = self.lineFragmentUsedRect(forGlyphAt: glyphRange.location, effectiveRange: nil)
                let textContainer = self.textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil)
        //****************** 正确的获取glyph绘制的Rect  *****************************
                var glyphRect = self.boundingRect(forGlyphRange: glyphRange, in: textContainer!)
                let position = self.location(forGlyphAt: glyphRange.location)//position是这个glyph的原点相对于lineRect的位置！
                glyphRect.size.height = position.y
                glyphRect.origin.x -= glyphRect.size.width
//                glyphRect.origin.y += position.y
                UIColor.green.setStroke()
                UIBezierPath.init(rect: glyphRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y)).stroke()
                //End
                UIColor.black.setStroke()
                UIBezierPath.init(rect: usedRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y)).stroke()
                //蓝色的lineFragmentRect
               let lineFragmentRect = self.lineFragmentRect(forGlyphAt: glyphRange.location, effectiveRange: nil)
                UIColor.blue.setStroke()
                UIBezierPath.init(rect: lineFragmentRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y+lineRect.size.height)).stroke()
              //获取line中的所有的插入点
                var positions = [CGFloat].init(repeating: 0.0, count: 200)
                var charIndexs = [Int].init(repeating: 0, count: 200)
              self.getLineFragmentInsertionPoints(forCharacterAt: charRange.location, alternatePositions: false, inDisplayOrder: true, positions: &positions, characterIndexes: &charIndexs)
              print("positions:\(positions)\ncharIndexs:\(charIndexs)")//
            }
        }else{

            let characterRange = self.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            let font = self.textStorage?.attributes(at: characterRange.location, effectiveRange: nil)[NSFontAttributeName] as! UIFont
            let ctfont = CTFontCreateWithName(font.fontName as CFString?, font.pointSize, nil);
            
            let startLocation = self.location(forGlyphAt: glyphRange.location)
            let endLocation = self.location(forGlyphAt: NSMaxRange(glyphRange))
            
            
            let  ctx = UIGraphicsGetCurrentContext();
            
            // -underlineGlyphRange:underlineType:lineFragmentRect:lineFragmentGlyphRange:containerOrigin: already set color and line width
            // for the current context
            
            // reset line width with current font underline thickness
            let underlinePostion = CTFontGetUnderlinePosition(ctfont)
        
            
            ctx?.setLineWidth(CTFontGetUnderlineThickness(ctfont))
            ctx?.move(to: CGPoint.init(x: startLocation.x + containerOrigin.x, y: startLocation.y + containerOrigin.y - CTFontGetUnderlinePosition(ctfont)+lineRect.size.height))
            ctx?.addLine(to: CGPoint.init(x: endLocation.x + containerOrigin.x, y:  endLocation.y + containerOrigin.y - CTFontGetUnderlinePosition(ctfont)+lineRect.size.height))
            
            ctx!.strokePath();
            
            
          /*  return
            if let container = textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil) {
                let boundingRect = self.boundingRect(forGlyphRange: glyphRange, in: container)
                let offsetRect = boundingRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y)
                UIColor.red.set()
                UIBezierPath(rect: offsetRect).stroke()
            }
            
            
            return */
            //Left border (== position) of first underlined graphly
            let point = self.location(forGlyphAt: glyphRange.location)
            let firstPosition:CGFloat = point.x
            print("\(point)")
            var lastPosition:CGFloat;
            if NSMaxRange(glyphRange) < NSMaxRange(lineGlyphRange)
            {
                let lastPoint = self.location(forGlyphAt: NSMaxRange(glyphRange))
                lastPosition = lastPoint.x
            }else
            {
                let size = self.lineFragmentUsedRect(forGlyphAt: NSMaxRange(glyphRange)-1, effectiveRange: nil).size
                lastPosition = size.width
            }
            //计算被调用次数
            count += 1
            print("\(self.count)")
            print("\(firstPosition)")
            var lineFragmentRect = lineRect
            print("containerOrigin:\(containerOrigin)")
            print("前lineFragmentRect:\(lineFragmentRect)")
            
            lineFragmentRect.origin.x += firstPosition
            lineFragmentRect.size.width = lastPosition - firstPosition
            
    //
            lineFragmentRect.origin.x += containerOrigin.x
            lineFragmentRect.origin.y += containerOrigin.y
            
            print("后lineFragmentRect:\(lineFragmentRect)")
            lineFragmentRect = lineFragmentRect.integral.insetBy(dx: 0.5, dy: 0.5);

            
            UIColor.red.set()
            UIBezierPath(rect: lineFragmentRect).stroke()
        }
        
        
        
        
    }
    
    
    override func setLineFragmentRect(_ fragmentRect: CGRect, forGlyphRange glyphRange: NSRange, usedRect: CGRect) {
        super.setLineFragmentRect(fragmentRect, forGlyphRange: glyphRange, usedRect: usedRect)
//        var lineFragmentRect = fragmentRect
//        lineFragmentRect = CGRectInset(CGRectIntegral(lineFragmentRect), 0.5, 0.5)
        
        
        //        UIColor.yellowColor().set()
        //        UIGraphicsBeginImageContext(fragmentRect.size)
        //        let context = UIGraphicsGetCurrentContext()
        //        UIGraphicsPushContext(context!)
//        UIColor.yellowColor().set()
        //        CGContextSaveGState(context)
        //        CGContextSetLineWidth(context, 1.0)
        //        CGContextSetLineJoin(context, CGLineJoin.Round)
//        UIBezierPath(rect: lineFragmentRect).stroke()
        
        //        let path = UIBezierPath(rect: lineFragmentRect)
        //        CGContextAddPath(context, path.CGPath)
        //        CGContextStrokePath(context)
        //        CGContextSetStrokeColorWithColor(context, UIColor.yellowColor().CGColor)
        //        CGContextRestoreGState(context)
        //        UIGraphicsPopContext()
        //        UIGraphicsEndImageContext()
        
    }
    
}
let CustomUnderlineStyle = 0x11

extension TKSOutliningLayoutManager{
    func drawFancyUnderlineForRect(_ rect: CGRect) {
        let left = rect.minX
        let bottom = rect.maxY
        let width = rect.width
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: left, y: bottom))
        var x = left
        var y = bottom
        var i = 0
        while (x <= left + width) {
            path.addLine(to: CGPoint(x: x, y: y))
            x += 2
            if i % 2 == 0 {
                y = bottom + 2.0
            }
            else {
                y = bottom
            }
            i += 1;
        }
        
        path.stroke()
    }

}

