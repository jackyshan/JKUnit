//
//  ImageTool.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/27.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import Foundation

open class ImageTool {
    public static func clearImage(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    public static func colorImage(_ size: CGSize, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let v = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        v.backgroundColor = color
        v.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
}
