//
//  BLEScanner.swift
//  renttravel
//
//  Created by jackyshan on 2017/3/9.
//  Copyright © 2017年 GCI. All rights reserved.
//

import UIKit
import CoreBluetooth

open class BLEScanner: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // MARK: - 1、公共属性
    open static let sharedInstance = BLEScanner()
    
    open var scanUUID: String?
    
    open var bleOpenFail: (() -> Void)?
    open var bleOpenSucc: (() -> Void)?
    open var bleWriteSucc: (() -> Void)?
    open var bleUpdateValue: ((_ data: Data) -> Void)?
    
    open var bleScanResult: ((_ devices: [BleDeviceModel]) -> Void)?
    private var scanBleResult = [BleDeviceModel]() {
        didSet {
            bleScanResult?(scanBleResult)
        }
    }
    open var bleConnectedDevice: BleDeviceModel?
    
    open var bleConnectSucc: ((_ device: BleDeviceModel) -> Void)?
    open var bleConnectFail: ((_ peripheral: CBPeripheral) -> Void)?
    
    // MARK: - 2、私有属性
    private var centerManager: CBCentralManager?
    
    // MARK: - 3、初始化
    fileprivate override init() {
        super.init()
        
        initLinstener()
    }
    
    func initLinstener() {
    }
    
    // MARK: - 4、视图
    
    // MARK: - 5、代理
    // MARK: CBCentralManagerDelegate
    // MARK: 恢复蓝牙连接之前的状态
//    public func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
//        Log.i(dict)
//    }
    
    // MARK: 蓝牙状态
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            switch central.state {
            case .unknown:
                Log.i("蓝牙未知原因")
                break
            case .resetting:
                Log.i("蓝牙连接超时")
                break
            case .unsupported:
                Log.i("不支持蓝牙4.0")
                break
            case .unauthorized:
                Log.i("连接失败")
                break
            case .poweredOff:
                Log.i("蓝牙未开启")
                break
            
            default:
                break
            }
            
            Log.i(">>>设备不支持BLE或者未打开")
            bleOpenFail?()
            stop()
        }
        else {
            Log.i(">>>BLE状态正常")
            bleOpenSucc?()
            if let UUID = scanUUID {
                centerManager?.scanForPeripherals(withServices: [CBUUID(string: UUID)], options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
            }
            else {
                centerManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
            }
        }
    }
    
    // MARK: 找到蓝牙设备
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        Log.i(">>>>扫描周边设备 .. 设备id:\(peripheral.identifier.uuidString), rssi: \(RSSI.stringValue), advertisementData: \(advertisementData), peripheral: \(peripheral)")
        
        let devices = scanBleResult.filter({$0.peripheral?.isEqual(peripheral) ?? false})
        guard devices.isEmpty else {
            return
        }
        
        let device = BleDeviceModel()
        device.peripheral = peripheral
        scanBleResult.append(device)
    }
    
    // MARK: 设备连接成功
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Log.i("和\(peripheral.name ?? "未知设备")设备连接成功。")
        peripheral.discoverServices(nil)
        peripheral.delegate = self
        centerManager?.stopScan()
        Log.i("扫描\(peripheral.name ?? "未知设备")设备上的服务..")
    }
    
    // MARK: 设备断开连接
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Log.i("\(peripheral.name ?? "未知设备")断开连接")
        
        bleConnectFail?(peripheral)
    }
    
    // MARK: 设备连接失败
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        Log.i("\(peripheral.name ?? "未知设备")连接失败")
        
        bleConnectFail?(peripheral)
    }
    
    // MARK: CBPeripheralDelegate
    // MARK: 发现服务
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            Log.i("查找 services 时 \(String(describing: peripheral.name)) 报错 \(String(describing: error?.localizedDescription))")
            return
        }
        
        Log.i("发现服务 ..")
        
        for service in peripheral.services! {
            //需要连接的 CBCharacteristic 的 UUID
            if let UUID = scanUUID {
                if service.uuid.uuidString == UUID {
                    peripheral.discoverCharacteristics(nil, for: service)
                    break
                }
            }
            else {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    // MARK: 发现特征
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            Log.i("查找 characteristics 时 \(String(describing: peripheral.name)) 报错 \(String(describing: error?.localizedDescription))")
            return
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        Log.i("发现服务特征 \(service.uuid), 特性数: \(String(describing: service.characteristics?.count))")
        
        //取第一个特征
        guard let characteristic = characteristics.first else {
            return
        }
        
        let devices = scanBleResult.filter({$0.peripheral!.isEqual(peripheral)})
        devices.first?.characteristic = characteristic
        if let device = devices.first {
            bleConnectedDevice = device
            bleConnectSucc?(device)
            
            peripheral.readValue(for: characteristic)
            //设置 characteristic 的 notifying 属性 为 true ， 表示接受广播
            peripheral.setNotifyValue(true, for: characteristic)
        }
        
        if let data = characteristic.value {
            Log.i("特性值byte： \((data as NSData).bytes)")
            Log.i("特性值string： \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
        }
    }
    
    // MARK: 发送写入蓝牙设备成功
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        Log.i("发送写入蓝牙设备成功")
        bleWriteSucc?()
    }
    
    // MARK: 主动方式(readValueForCharacteristic)收到蓝牙设备返回数据,readValueForCharacteristic方法之后
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        Log.i("主动方式read收到蓝牙设备返回数据")
        
        if let data = characteristic.value {
            bleUpdateValue?(data)
        }
    }
    
    // MARK: 被动方式(通知setNotifyValue:forCharacteristic)收到蓝牙设备返回数据
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        Log.i("被动方式nofity收到蓝牙设备返回数据")
        
        if let data = characteristic.value {
            bleUpdateValue?(data)
        }
    }
    
    // MARK: - 6、公共业务
    open func start() {
        stop()
        centerManager = CBCentralManager(delegate: self, queue: DispatchQueue.main, options: [CBCentralManagerOptionShowPowerAlertKey : false])
    }
    
    open func stop() {
        scanBleResult.removeAll()
        centerManager?.stopScan()
        centerManager = nil
    }
    
    open func connect(_ peripheral: CBPeripheral) {
        centerManager?.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnConnectionKey : true, CBConnectPeripheralOptionNotifyOnDisconnectionKey : true, CBConnectPeripheralOptionNotifyOnNotificationKey : true])
    }
    
    open func disConnect(_ peripheral: CBPeripheral) {
        centerManager?.cancelPeripheralConnection(peripheral)
    }
    
    open func retrievePeripheral(_ UUIDString: String) -> CBPeripheral? {
        guard let uuid = UUID(uuidString: UUIDString) else {
            return nil
        }
        
        return centerManager?.retrievePeripherals(withIdentifiers: [uuid]).first
    }
    
    // MARK: - 7、私有业务
    
    // MARK: - 8、其他
    
}
