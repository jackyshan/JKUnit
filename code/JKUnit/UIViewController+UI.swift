//
//  UIViewController+UI.swift
//  JKUnit
//
//  Created by jackyshan on 2018/2/25.
//  Copyright © 2018年 jackyshan. All rights reserved.
//

import Foundation

@IBDesignable
public extension UIViewController {
    @IBInspectable var localString: String? {
        get {
            return self.title
        }
        
        set {
            if newValue != nil {
                self.title = NSLocalizedString(newValue!, comment: "")
            }
            else {
                self.title = nil
            }
        }
    }
}
