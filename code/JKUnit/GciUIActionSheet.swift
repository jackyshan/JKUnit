//
//  GciUIActionSheet.swift
//  rentStudent
//
//  Created by 黄超 on 16/6/2.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


open class GciUIActionSheet<T:Any>:NSObject,UIActionSheetDelegate {
    fileprivate var mDataSoure:[T]?
    fileprivate var mAdapter:((_ obj:T)->String)?
    fileprivate var mAction:((_ obj:T)->Void)?
    fileprivate var mActionSheet:UIActionSheet?
    fileprivate var mDict = Dictionary<Int,Int>()
    
    public override init() {
        super.init()
    }
    
    open func setDataSoure(_ datas:[T],adapter:@escaping (_ obj:T)->String){
        self.mDataSoure = datas
        self.mAdapter = adapter
        
    }
    open func showInView(_ title:String?,view: UIView,action:@escaping (_ obj:T) -> Void) {
        self.mAction = action
        self.mActionSheet = UIActionSheet(title: title, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        if mDataSoure != nil {
            for i in 0..<(self.mDataSoure?.count ?? 0) {
                let index = self.mActionSheet!.addButton(withTitle: self.mAdapter!(mDataSoure![i]))
                mDict[index] = i
            }
        }
        self.mActionSheet?.show(in: view)
    }
    
    open func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        let item:Int? = mDict[buttonIndex]
        if item != nil {
            self.mAction?(self.mDataSoure![item!])
        }
    }
}
