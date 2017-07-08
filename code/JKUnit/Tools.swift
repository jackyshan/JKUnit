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
    
    // MARK: delay block
    public typealias Task = (_ cancel : Bool) -> Void
    open static func delay(time:Int64, task:@escaping ()->()) ->  Task? {
        
        func dispatch_later(block:@escaping ()->()) {
            let timeE:DispatchTime = DispatchTime.now() + Double(time*Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC);
            DispatchQueue.main.asyncAfter(deadline: timeE, execute: block)
        }
        
        var closure: (()->())? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure);
                }
            }
            
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }

}
