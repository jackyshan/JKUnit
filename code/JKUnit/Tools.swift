//
//  Tools.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/26.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import Foundation

open class Tools {
    // MARK: bundleName
    open static let BundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
    
    // MARK: bundleResource
    private static var jkBundle:Bundle? = nil
    public static func getResourceFromBunlde(filename: String) -> UIImage? {
        var result:UIImage? = nil
        
        if jkBundle == nil {
            let bundle = Bundle(for: Tools.self)
            
            if let resourcePath = bundle.path(forResource: "JKUnitBundle", ofType: "bundle") {
                if let resourcesBundle = Bundle(path: resourcePath) {
                    jkBundle = resourcesBundle
                }
            }
        }
        
        if jkBundle != nil {
            result = UIImage.init(named: filename, in: jkBundle, compatibleWith: nil)
        }
        
        return result
    }
    
    // MARK: app version
    open static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    // MARK: app build version
    open static func getAppBuildVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }

}
