//
//  NavigationTool.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/27.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import Foundation

open class NavigationTool {
    open static let navClearImage = ImageTool.clearImage(CGSize(width: UIScreen.main.bounds.width,height: 64))
    open static let navWhiteImage = ImageTool.colorImage(CGSize(width: UIScreen.main.bounds.width,height: 64), color: UIColor.white)
    open static let navBlackBackImage = Tools.getResourceFromBunlde(filename: "black_back")
}
