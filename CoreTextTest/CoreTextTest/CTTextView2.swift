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
    override func draw(_ rect: CGRect) {
        // 1 获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 2 转换坐标
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        // 3 绘制区域
        let path = UIBezierPath(rect: rect)
        
        // 4 创建需要绘制的文字
        let attrString = "来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这"
        
        // 5 设置frame
        let mutableAttrStr = NSMutableAttributedString(string: attrString)
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttrStr.length), path.cgPath, nil)
        // 6 绘制
        CTFrameDraw(frame, context!)
        
        
    }
    

}
