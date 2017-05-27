//
//  NSObject+Extension.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/27.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

public extension NSObject {
    public func getClassName() -> String {
        return NSStringFromClass(self.classForCoder)
    }
}
