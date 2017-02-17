//
//  TextKitVC2Label.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/7.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import UIKit

class TextKitVC2Label: UILabel {
    //MARK:- TextKit 的核心对象
    fileprivate lazy var textStorage = NSTextStorage()
    fileprivate lazy var layoutManager = NSLayoutManager()
    fileprivate lazy var textContainer = NSTextContainer()
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  textContainer.size = frame.size
        prepareTextSystem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTextSystem()
        fatalError("init(coder:) has not been implemented")
    }
    override var text: String?{
        didSet{
            prepareTexStorageString()
        }
    }
    override var attributedText: NSAttributedString?{
        didSet{
            prepareTexStorageString()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = bounds.size
    }
    func prepareTextSystem()  {
        isUserInteractionEnabled = true
        prepareTexStorageString()
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
      //  layoutManager.allowsNonContiguousLayout = false
        textContainer.lineFragmentPadding = 0
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true

    }
    func prepareTexStorageString()  {
        if let text = text{
            textStorage.setAttributedString(NSAttributedString(string: text))
        }else if let text = attributedText{
            textStorage.setAttributedString(NSAttributedString(attributedString: text))
        }else{
            textStorage.setAttributedString(NSAttributedString(string:""))
        }
       let string =  textStorage.string as NSString
        textStorage.addAttributes([NSFontAttributeName:font], range: NSRange.init(location: 0, length: string.length))
        //处理url链接属性
        for range in urlRanges ?? [] {
            textStorage.addAttributes([NSForegroundColorAttributeName:UIColor.red,NSBackgroundColorAttributeName:UIColor.groupTableViewBackground,NSUnderlineStyleAttributeName:1] ,range: range)
          //没看出什么区别  textStorage.addAttributes([NSTextEffectAttributeName:NSTextEffectLetterpressStyle], range: range)
            
        }
    }
    // #MARK: - 重写Drawfangfa
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)//如果不调用super的draw方法的话就不会绘制文字，不过背景居然能绘制，好奇妙
        let range = NSRange.init(location: 0, length: textStorage.string.characters.count)//emoji的话其实是相当于两个字符长度的，所以tring.characters.count获取的不准,替代为textStorage.length
        var characterRange = NSRange()
        let string =  textStorage.string as NSString
        let nsStringRange = NSRange.init(location: 0,length: string.length)
        let glyphRange = layoutManager.glyphRange(forCharacterRange: nsStringRange, actualCharacterRange: &characterRange)
        let glyphrange2 = layoutManager.glyphRange(for: textContainer)
        layoutManager.drawBackground(forGlyphRange: glyphrange2, at: CGPoint())
        layoutManager.drawGlyphs(forGlyphRange: glyphrange2, at: CGPoint.init(x: 0, y: 0))
    
    }

    // #MARK: - 交互
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let index = layoutManager.glyphIndex(for: location, in: textContainer)
        let characterIndex = layoutManager.characterIndexForGlyph(at: index)
        for range in urlRanges! {
            if NSLocationInRange(index, range) {
               textStorage.addAttributes([NSBackgroundColorAttributeName:UIColor.flatBlue], range: range)
               setNeedsDisplay()
            }else{
                print("不在")
            }
        }
        print("点击的是第\(characterIndex)个字符，第\(index)个字形")
    }

}
fileprivate extension TextKitVC2Label{
    //查找出url的的位置数组
    var urlRanges:[NSRange]?{
        let pattern = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
        guard  let rex = try?NSRegularExpression(pattern: pattern, options: [])else{
            return nil
        }
        let matches = rex.matches(in: textStorage.string, options: [], range:NSRange.init(location: 0, length:  textStorage.string.characters.count))
        var ranges = [NSRange]()
        for result in matches {
            ranges.append(result.rangeAt(0))
        }
        return ranges
    }
}

