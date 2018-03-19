//
//  UILabel+UI.swift
//  JKUnit
//
//  Created by jackyshan on 2018/2/25.
//  Copyright © 2018年 jackyshan. All rights reserved.
//

import Foundation

@IBDesignable
public extension UILabel {
    @IBInspectable var localString: String? {
        get {
            return self.text
        }
        
        set {
            if newValue != nil {
                self.text = NSLocalizedString(newValue!, comment: "")
            }
            else {
                self.text = nil
            }
        }
    }
}
