//
//  BleHelper.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/29.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

open class BleHelper: NSObject {
    open static func cnBleConnectFailAlert() {
        let vc = UIAlertController.init(title: "温馨提示", message: "打开蓝牙连接到配件", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        vc.addAction(cancelAction)
        let okAction = UIAlertAction.init(title: "确定", style: .default) { (action) in
            BleHelper.openSettingBle()
        }
        vc.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    open static func enBleConnectFailAlert() {
        let vc = UIAlertController.init(title: "Tip", message: "Open Ble For Connecting Device", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        vc.addAction(cancelAction)
        let okAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            BleHelper.openSettingBle()
        }
        vc.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    open static func openSettingBle() {
        if UIApplication.shared.canOpenURL(URL.init(string: "prefs:root=Bluetooth")!) {
            UIApplication.shared.openURL(URL.init(string: "prefs:root=Bluetooth")!)
        }
        else if UIApplication.shared.canOpenURL(URL.init(string: "App-Prefs:root=Bluetooth")!) {
            UIApplication.shared.openURL(URL.init(string: "App-Prefs:root=Bluetooth")!)
        }
    }
}
