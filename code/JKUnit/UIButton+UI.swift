//
//  UIButton+UI.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/27.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import Foundation

@IBDesignable
public extension UIButton {
    @IBInspectable var enabledBgImgColor: UIColor? {
        get {
            return self.enabledBgImgColor
        }
        
        set {
            if newValue != nil {
                self.setBackgroundImage(ImageTool.colorImage(CGSize.init(width: self.bounds.width, height: self.bounds.height), color: newValue!), for: .normal)
            }
            else {
                self.setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    @IBInspectable var disabledBgImgColor: UIColor? {
        get {
            return self.disabledBgImgColor
        }
        
        set {
            if newValue != nil {
                self.setBackgroundImage(ImageTool.colorImage(CGSize.init(width: self.bounds.width, height: self.bounds.height), color: newValue!), for: .disabled)
            }
            else {
                self.setBackgroundImage(nil, for: .disabled)
            }
        }
    }

}
