//
//  ExtentionUikit.swift
//  CoreTextTest
//
//  Created by I_MT on 2017/2/10.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setcornerRadius(value:CGFloat)  {
        self.layer.cornerRadius = CGFloat(value)
        self.layer.masksToBounds = true
    }

}
