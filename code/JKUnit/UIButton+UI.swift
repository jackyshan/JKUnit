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
    
    
    @IBInspectable var selectedBgImgColor: UIColor? {
        get {
            return self.selectedBgImgColor
        }
        
        set {
            if newValue != nil {
                self.setBackgroundImage(ImageTool.colorImage(CGSize.init(width: self.bounds.width, height: self.bounds.height), color: newValue!), for: .selected)
            }
            else {
                self.setBackgroundImage(nil, for: .selected)
            }
        }
    }
    
    @IBInspectable var deSelectedBgImgColor: UIColor? {
        get {
            return self.deSelectedBgImgColor
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

    @IBInspectable var localString: String? {
        get {
            return self.currentTitle
        }
        
        set {
            if newValue != nil {
                self.setTitle(NSLocalizedString(newValue!, comment: ""), for: .normal)
            }
            else {
                self.setTitle(nil, for: .normal)
            }
        }
    }
    
    @IBInspectable var localSelectedString: String? {
        get {
            return self.currentTitle
        }
        
        set {
            if newValue != nil {
                self.setTitle(NSLocalizedString(newValue!, comment: ""), for: .selected)
            }
            else {
                self.setTitle(nil, for: .selected)
            }
        }
    }

}
