//
//  BaseTableViewAdapter.swift
//  JKUnit
//
//  Created by jackyshan on 2017/6/25.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

open class BaseTableViewAdapter<T>: NSObject, UITableViewDelegate, UITableViewDataSource {
    fileprivate var mDataSource:[T]?
    var cellClick:((_ obj:T)->Void)?
    var cellClickIndex:((_ obj:T,_ index:IndexPath)->Void)?
    
    open var cellHeight:CGFloat = 60
    
    open var mTableView:UITableView?
    open var DataSoure:[T] = []{
        willSet{
            mDataSource = newValue
        }
        
        didSet{
            mTableView!.dataSource = self
            mTableView!.delegate = self
            mTableView!.tableFooterView = UIView(frame: CGRect.zero)
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
        return 1
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mTableView!.deselectRow(at: indexPath, animated: true)
        self.cellClick?(self.mDataSource![indexPath.row])
        self.cellClickIndex?(self.mDataSource![indexPath.row], indexPath)
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(self.mDataSource?.count)
        return self.mDataSource!.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data:T = self.mDataSource![indexPath.row]
        return gciTableView(tableView, cellForRowAtIndexPath: indexPath, bingData: data)
    }
    
    open func gciTableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath,bingData:T) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        return cell
    }
    
    open func cellOnClick(_ action:@escaping (T) -> Void){
        self.cellClick = action
    }
    
    open func cellOnClickIndex(_ action:@escaping (_ obj:T,_ index:IndexPath)->Void){
        self.cellClickIndex = action
    }
    
    deinit {
        self.mTableView?.dataSource = nil
        self.mTableView?.delegate = nil
    }
    
}
