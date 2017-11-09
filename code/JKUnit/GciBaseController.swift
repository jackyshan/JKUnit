//
//  GciBaseController.swift
//  rentStudent
//
//  Created by 黄超 on 16/5/16.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

open class GciBaseController: UIViewController {
    var didSetupConstraints = false
    var didSystemAutoLayout = false
    var didAnimateComplete = false
    
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
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAnimateComplete {
            didViewAnimateComplete()
            didAnimateComplete = true
        }
    }
    
    open func didViewAnimateComplete(){ }
    
   open func didSnpKitUiLoad() -> Void{}
   open func didSystemAutoLayoutComplete() -> Void{}
}
