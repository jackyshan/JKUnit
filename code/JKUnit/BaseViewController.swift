//
//  BaseViewController.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/26.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    var didSetupConstraints = false
    var didSystemAutoLayout = false
    var didAnimateComplete = false
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let appIdx = NSStringFromClass(self.classForCoder).range(of: Tools.BundleName)?.upperBound {
            Log.i("进入页面"+NSStringFromClass(self.classForCoder).substring(from: appIdx))
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAnimateComplete {
            didViewAnimateComplete()
            didAnimateComplete = true
        }
        
        if let appIdx = NSStringFromClass(self.classForCoder).range(of: Tools.BundleName)?.upperBound {
            Log.i("离开页面"+NSStringFromClass(self.classForCoder).substring(from: appIdx))
        }
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        if !didSetupConstraints {
            didSnpKitUiLoad()
            didSetupConstraints = true
        }
    }
    
    open override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        if !didSystemAutoLayout{
            didSystemAutoLayoutComplete()
            didSystemAutoLayout = true
        }
    }
    
    open func didViewAnimateComplete(){ }
    open func didSnpKitUiLoad() -> Void{}
    open func didSystemAutoLayoutComplete() -> Void{}

}
