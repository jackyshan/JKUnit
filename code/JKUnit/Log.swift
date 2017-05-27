//
//  Log.swift
//  renttravel
//
//  Created by jackyshan on 2017/4/25.
//  Copyright © 2017年 GCI. All rights reserved.
//

import Foundation

open class Log {
    open static func i<T>(_ message: T,
                  file: String = #file,
                  method: String = #function,
                  line: Int = #line)
    {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \n\(message)")
        #endif
    }
}
