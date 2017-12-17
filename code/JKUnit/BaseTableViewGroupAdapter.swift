//
//  BaseTableViewGroupAdapter.swift
//  JKUnit
//
//  Created by jackyshan on 2017/12/9.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

open class BaseTableViewGroupAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    fileprivate var mDataSource:[GropTableViewItem] = []
    open var mTableView:UITableView?
    var cellClickIndex:((_ key:String?,_ obj:Any?,_ index:IndexPath)->Void)?
    
    open var cellHeight:CGFloat = 60
    open var DataSoure:[GropTableViewItem] = [] {
        willSet{
            mDataSource = newValue
        }
        didSet{
            mTableView!.dataSource = self
            mTableView!.delegate = self
            mTableView!.reloadData()
        }
    }
    
    public init(tableView:UITableView) {
        super.init()
        self.mTableView = tableView
        onCreate()
    }
    
    open func onCreate(){}
    open func numberOfSections(in tableView: UITableView) -> Int {
        return DataSoure.count
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    open func gciTableView(_ tableView: UITableView, heightWithKeyInDict key: String,bingData:Any,indexPath:IndexPath) -> CGFloat {
        return cellHeight
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mTableView!.deselectRow(at: indexPath, animated: true)
        let key:String = DataSoure[indexPath.section].Key
        self.cellClickIndex?(key,DataSoure[indexPath.section].DataList[indexPath.row],indexPath)
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSoure[section].DataList.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let key:String = DataSoure[indexPath.section].Key
        let obj = DataSoure[indexPath.section].DataList[indexPath.row]
        return gciTableView(tableView, heightWithKeyInDict: key,bingData: obj,indexPath: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key:String = DataSoure[indexPath.section].Key
        let obj = DataSoure[indexPath.section].DataList[indexPath.row]
        return gciTableView(tableView, cellForRowAtIndexPath: indexPath,key: key,bingData: obj)
    }
    
    open func gciTableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath, key:String, bingData:Any) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        return cell
    }
    
    open func cellOnClickIndex(_ action:@escaping (_ key:String?,_ obj:Any?,_ index:IndexPath)->Void){
        self.cellClickIndex = action
    }
    
}

public struct GropTableViewItem {
    public init(Key:String,DataList:[Any]){
        self.Key = Key
        self.DataList = DataList
    }
    public var Key:String = ""
    public var DataList:[Any] = []
}

