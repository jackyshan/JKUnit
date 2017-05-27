//
//  VeryCodeBtn.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/27.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import Foundation

open class VeryCodeBtn: UIButton {
    var ctitle: String?
    private weak var timer: Timer?
    
    @IBInspectable var duration: Int = 60
    
    var reduceNum: Int!
    
    open func startTimer() {
        timer?.invalidate()
        timer = nil
        
        self.isEnabled = false
        ctitle = self.currentTitle
        
        reduceNum = duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    open func stopTimer() {
        guard timer != nil else {
            return
        }
        
        timer?.invalidate()
        timer = nil
        self.isEnabled = true
        self.setTitle(ctitle, for: .normal)
    }
    
    func timerAction() {
        reduceNum = reduceNum - 1
        self.setTitle("\(reduceNum!)s", for: .disabled)
        
        if reduceNum <= 0 {
            stopTimer()
        }
    }
    
}
