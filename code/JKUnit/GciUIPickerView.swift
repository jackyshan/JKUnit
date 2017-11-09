//
//  GciUIPickerView.swift
//  rentStudent
//
//  Created by 黄超 on 16/5/19.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit
/**
 * 使用分组控件封装，使用时注意使用成员对象
 */
open class GciUIPickerView<T:Any> : NSObject {
    
    weak var controller:UIViewController?
    
    var rowHeight:CGFloat = 40
    var font:UIFont = UIFont.systemFont(ofSize: 17)
    
    var toolBar:GciUIView?
    var pickView:GciUIPickerGroupView!
    
    
    fileprivate var dataSoure:[T]?
    fileprivate var didClick:((T)->Void)?
    fileprivate var showTitle:((T)->String)?
    
    public override init(){
        super.init()
        pickView = GciUIPickerGroupView()
    }
    
    
    open func setDataSoure(_ dataSoures:[T],showtitle:@escaping (_ obj:T)->String){
        self.showTitle = showtitle
        self.dataSoure = dataSoures
        let anySource = dataSoures.map { (obj) -> Any in
            return obj
        }
        let gciPickData = GciPickerItem(Key: "SingleView", Sourece: anySource)
        self.pickView.setDataSoure([gciPickData]) {[unowned self] (key, obj, indexpath) -> String in
            return self.showTitle!(obj as! T)
        }
    }
    
    open func showInView(_ title:String,contrller: UIViewController,didCilickOk:@escaping (_ obj:T)-> Void){
        if self.dataSoure == nil{
            return
        }
        self.controller = contrller
        self.didClick = didCilickOk
        
        self.pickView.showInView(Title: title,contrller: contrller) {[unowned self] (objs:[Any]) in
            if objs.count > 0 {
                let data = objs[0] as! T
                self.didClick?(data)
            }
        }
    }
    
    open func showInView(_ contrller: UIViewController,didCilickOk:@escaping (_ obj:T)-> Void) {
        self.showInView("",contrller:  contrller, didCilickOk: didCilickOk)
    }
    
}
