//
//  BleDeviceModel.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/29.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit
import CoreBluetooth

open class BleDeviceModel: NSObject {
    open var peripheral: CBPeripheral?
    open var characteristic: CBCharacteristic?
}
