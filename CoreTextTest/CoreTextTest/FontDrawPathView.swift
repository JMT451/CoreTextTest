//
//  FontDrawPathView.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/14.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

public protocol FontDrawPathViewDelegate {
    func textAnimator(_ textAnimator: FontDrawPathView, animationDidStart animation: CAAnimation)
    func textAnimator(_ textAnimator: FontDrawPathView, animationDidStop animation: CAAnimation)
}
open class FontDrawPathView: UIView,CAAnimationDelegate {
    // MARK: Properties
    open var fontName         = "Avenir"
    open var fontSize         : CGFloat = 50.0
    open var textColor        = UIColor.red.cgColor
    open var delegate :FontDrawPathViewDelegate?
    fileprivate var animationLayer  = CALayer()
    fileprivate var pathLayer       : CAShapeLayer?
    fileprivate var storkeAnimation :CABasicAnimation?//将要执行的外部轮廓动画
    fileprivate var colorAnimation:CAPropertyAnimation?//将要执行的内部fillColor的动画
    open var textToAnimate    = "Hello Swift!"{
        didSet{
            reloadText()
        }
    }
    public var showAnimateType :showType = .default_type{
        willSet{
            
        }
        didSet{
            reloadText()
        }
    }
    
   public enum showType {
        case default_type
        case animatedPath_type
        case progress_type
    }
   
     override init(frame: CGRect) {
        super.init(frame: frame)
        defaultConfiguration()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultConfiguration()
    }
    deinit {
        clearLayer()
    }
    fileprivate func clearLayer() {
        if let _ = pathLayer {
            pathLayer?.removeFromSuperlayer()
            pathLayer = nil
        }
    }

    fileprivate func defaultConfiguration() {
        animationLayer          = CALayer()
        animationLayer.frame    = self.bounds
        self.layer.addSublayer(animationLayer)
        setupPathLayerWithText(textToAnimate, fontName: fontName, fontSize: fontSize)
        prepareForAnimation()
    }
  public  func reloadText() {
        prepareForAnimation()
        switch self.showAnimateType {
        case .default_type: break
            pathLayer?.removeAllAnimations()
        case .animatedPath_type:
            startAnimation()
        case .progress_type:
            startAnimation()
            
        }

    }
    fileprivate func setupPathLayerWithText(_ text: String, fontName: String, fontSize: CGFloat) {
        clearLayer()
        
        let letters     = CGMutablePath()
        let font        = CTFontCreateWithName(fontName as CFString?, fontSize, nil)
        let sysFont = UIFont.systemFont(ofSize: 12.0)
        let sysFontName = sysFont.familyName
     /*   let sysFontRef = CTFontCreateWithName(sysFontName as CFString, 12.0, nil)
        let supports = CTFontGetGlyphWithName(sysFont, "😀" as CFString)
        */// 测试是否支持
        let attrString  = NSAttributedString(string: text, attributes: [kCTFontAttributeName as String : font])
        let line        = CTLineCreateWithAttributedString(attrString)
        let runArray    = CTLineGetGlyphRuns(line)
        
        for runIndex in 0..<CFArrayGetCount(runArray) {
            
            let run     : CTRun =  unsafeBitCast(CFArrayGetValueAtIndex(runArray, runIndex), to: CTRun.self)
            let dictRef : CFDictionary = unsafeBitCast(CTRunGetAttributes(run), to: CFDictionary.self)
            let dict    : NSDictionary = dictRef as NSDictionary
            let runFont = dict[kCTFontAttributeName as String] as! CTFont
            
            for runGlyphIndex in 0..<CTRunGetGlyphCount(run) {
                let thisGlyphRange  = CFRangeMake(runGlyphIndex, 1)
                var glyph           = CGGlyph()
                var position        = CGPoint.zero
                CTRunGetGlyphs(run, thisGlyphRange, &glyph)
                CTRunGetPositions(run, thisGlyphRange, &position)
                
                let letter          = CTFontCreatePathForGlyph(runFont, glyph, nil)
                let t               = CGAffineTransform(translationX: position.x, y: position.y)
                if let letter = letter  {
                    letters.addPath(letter, transform: t)
                }
            }
        }
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.append(UIBezierPath(cgPath: letters))
        
        let pathLayer               = CAShapeLayer()
        pathLayer.frame             = animationLayer.bounds;
        pathLayer.bounds            = path.cgPath.boundingBox
        pathLayer.isGeometryFlipped   = true
        pathLayer.path              = path.cgPath
        pathLayer.strokeColor       = UIColor.black.cgColor
        pathLayer.fillColor         = UIColor.clear.cgColor
        pathLayer.lineWidth         = 1.0
        pathLayer.lineJoin          = kCALineJoinBevel
        
        self.animationLayer.addSublayer(pathLayer)
        self.pathLayer = pathLayer
        
    }
    /*default ：不开
     *animation :自动开
     *progress：自动开
     */
    open func startAnimation() {
        if  let animation = storkeAnimation {
            pathLayer?.add(animation, forKey: "strokeEnd")
        }
        if  let animation = colorAnimation {
            pathLayer?.add(animation, forKey: "fillColor")
        }
    }
    
    open func stopAnimation() {
        pathLayer?.removeAllAnimations()
    }
    
    open func clearAnimationText() {
        clearLayer()
    }
    
    open func prepareForAnimation() {
        pathLayer?.removeAllAnimations()
        colorAnimation = nil
        storkeAnimation = nil
        setupPathLayerWithText(textToAnimate, fontName: fontName, fontSize: fontSize)
        switch self.showAnimateType {
        case .default_type:
            break;
        case .animatedPath_type:
            let duration = 4.0
            
            storkeAnimation       = CABasicAnimation(keyPath: "strokeEnd")
            storkeAnimation?.duration  = duration
          //  storkeAnimation?.repeatCount = Float(Int.max)
            storkeAnimation?.fromValue = 0.0
            storkeAnimation?.toValue   = 1.0
            storkeAnimation!.delegate  = self
            pathLayer?.add(storkeAnimation!, forKey: "strokeEnd")
            let coloringDuration        = 2.0
            colorAnimation          = CAKeyframeAnimation(keyPath: "fillColor")
            colorAnimation?.duration     = duration + coloringDuration
            let realAniamtion = colorAnimation as! CAKeyframeAnimation
            realAniamtion.values       = [UIColor.clear.cgColor, UIColor.clear.cgColor, textColor]
            let num = NSNumber(value: duration/(duration + coloringDuration))
            realAniamtion.keyTimes     = [0,num, 1]

        case .progress_type:
            
            storkeAnimation       = CABasicAnimation(keyPath: "strokeEnd")
            storkeAnimation?.duration  = 1.0
            storkeAnimation?.fromValue = 0.0
            storkeAnimation?.toValue   = 1.0
            storkeAnimation?.delegate  = self
            pathLayer?.add(storkeAnimation!, forKey: "strokeEnd")
            
            pathLayer?.speed        = 0
        }
        
    }
    
    open func updatePathStrokeWithValue(_ value: Float) {
        if self.showAnimateType != .progress_type {
            return
        }
        pathLayer?.timeOffset = CFTimeInterval(value)
    }
    
    // MARK: Animation delegate
    public func animationDidStart(_ anim: CAAnimation) {
        
        self.delegate?.textAnimator(self, animationDidStart: anim)
    }
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.delegate?.textAnimator(self, animationDidStop: anim)
    }


}
