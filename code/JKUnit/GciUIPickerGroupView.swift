//
//  GciUIPickerGroupView.swift
//  GciUnit
//
//  Created by 黄超 on 16/9/9.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

open class GciUIPickerGroupView : UIActionSheet,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    open weak var groupDelegate:GciGropViewDelegate?
    
    weak var controller:UIViewController?
    
    
    open var rowHeight:CGFloat = 40
    open var font:UIFont = UIFont.systemFont(ofSize: 17)
    open var pickerHeight:CGFloat = 250
    
    var toolBar:GciUIView?
    var pickViews:[UIPickerView] = []
    var selectView:UIView?
    
    fileprivate var dataSoure:[GciPickerItem]?
    fileprivate var didClick:(([Any])->Void)?
    fileprivate var didClickDict:(([String:Any])->Void)?
    fileprivate var showTitle:((String,Any,IndexPath)->String)?
    
    public init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func actionBtn(_ width:CGFloat,title:String) -> UIView{
//        let okColor = UIColor(red: 218/255, green: 78/255, blue: 91/255, alpha: 1)
//        let cancelColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 200/255)
        
        let tool:GciUIView = GciUIView(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        
        self.toolBar = tool
        let color:UIColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        tool.border_top = 1
        tool.borderColor_top = color
        tool.border_bottom = 1
        tool.borderColor_bottom = color
        
        tool.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
//        tool.backgroundColor = UIColor.whiteColor()
        
        let cancelBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.setTitleColor(ViewUitl.getUIColorByHex(red: 0x48, green: 0x48, blue: 0x48, alpha: 1), for: UIControlState())
        cancelBtn.setTitleColor(UIColor.red, for: .highlighted)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), for: .touchUpInside)
        cancelBtn.sizeToFit()
        tool.addSubview(cancelBtn)
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        let cancelc = NSLayoutConstraint(item: cancelBtn, attribute: .leading, relatedBy: .equal, toItem: tool, attribute: .leading, multiplier: 1, constant: 10)
        let cancelY = NSLayoutConstraint(item: cancelBtn, attribute: .centerY, relatedBy: .equal, toItem: tool, attribute: .centerY, multiplier: 1, constant: 0)
        tool.addConstraint(cancelc)
        tool.addConstraint(cancelY)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        titleLabel.textAlignment = .center
        titleLabel.textColor = ViewUitl.getUIColorByHex(red: 0x48, green: 0x48, blue: 0x48, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.text = title
        tool.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
        let okBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        okBtn.setTitle("确定", for: UIControlState())
        okBtn.setTitleColor(ViewUitl.getUIColorByHex(red: 0x48, green: 0x48, blue: 0x48, alpha: 1), for: UIControlState())
        okBtn.setTitleColor(UIColor.red, for: .highlighted)
        okBtn.addTarget(self, action: #selector(self.doneBtnClick), for: .touchUpInside)
        okBtn.sizeToFit()
        tool.addSubview(okBtn)
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let okc = NSLayoutConstraint(item: okBtn, attribute: .trailing, relatedBy: .equal, toItem: tool, attribute: .trailing, multiplier: 1, constant: -10)
        let okY = NSLayoutConstraint(item: okBtn, attribute: .centerY, relatedBy: .equal, toItem: tool, attribute: .centerY, multiplier: 1, constant: 0)
        
        tool.addConstraint(okc)
        tool.addConstraint(okY)
        return tool
    }
    
    func actionUIPickView(_ size:CGSize) -> [UIPickerView]{
        let pickViewWidth = size.width / CGFloat(self.dataSoure!.count)
        self.pickViews = Array<UIPickerView>()
        for i in 0..<dataSoure!.count {
            let pickView = UIPickerView(frame: CGRect(x: CGFloat(i) * pickViewWidth, y: 44, width: pickViewWidth, height: size.height) )
            pickView.showsSelectionIndicator = true
            pickView.tag = i
            pickView.dataSource = self
            pickView.delegate = self
            pickView.selectRow(0, inComponent: 0, animated: true)
            pickView.backgroundColor = UIColor.white
            self.pickViews.append(pickView)
        }
        return self.pickViews
    }
    
//    func actionUIPickView(size:CGSize) -> UIPickerView{
////        let pickViewWidth = size.width / CGFloat(self.dataSoure!.count)
//        pickView = UIPickerView(frame: CGRect(x: 0, y: 44, width: size.width, height: size.height) )
//        pickView!.showsSelectionIndicator = true
//        pickView!.dataSource = self
//        pickView!.delegate = self
//        pickView!.selectRow(0, inComponent: 0, animated: true)
//        pickView!.backgroundColor = UIColor.whiteColor()
//        return pickView!
//    }
    
    open func setDataSoureByKey(_ key:String,data:[Any]){
        if self.dataSoure != nil {
            for i in 0..<self.dataSoure!.count {
                let item = self.dataSoure![i]
                if item.Key == key {
                    self.dataSoure![i].Sourece = data
                    self.pickViews[i].reloadAllComponents()
                    break
                }
            }
        }
    }
    
    open func setSelectRow(_ inComponent:Int,row:Int,animated:Bool){
        if dataSoure == nil{
            return
        }
        self.pickViews[inComponent].selectRow(row, inComponent: 0, animated: animated)
    }
    
    open func getCurSelect() -> [String:Any] {
        var selects:[String:Any] = [:]
        for i in 0..<self.dataSoure!.count {
            let index = self.pickViews[i].selectedRow(inComponent: 0)
            let curModel = self.dataSoure![i]
            selects[curModel.Key] = curModel.Sourece![index]
        }
        return selects
    }
    
    open func setSelectRow(Inkey key:String,row:Int,animated:Bool){
        if dataSoure == nil{
            return
        }
        var inComponent = 0
        for i in 0..<self.dataSoure!.count {
            let item  = self.dataSoure![i]
            if item.Key == key {
                inComponent = i
                break
            }
        }
        self.pickViews[inComponent].selectRow(row, inComponent: 0, animated: animated)
        self.pickerView(self.pickViews[inComponent], didSelectRow: row, inComponent: 0)
    }
    
    open func setDataSoure(_ dataSoures:[GciPickerItem],showtitle:@escaping (String,Any,IndexPath)->String) {
        self.showTitle = showtitle
        self.dataSoure = dataSoures
    }
    
    fileprivate func createSelectView(_ size:CGSize,title:String) -> UIView {
        let y = UIScreen.main.bounds.size.height
        selectView = UIView(frame:CGRect(x: 0, y: y, width: size.width, height: size.height))
        selectView!.backgroundColor = ViewUitl.getUIColorByHex(red: 0xf7, green: 0xf7, blue: 0xf7, alpha: 1)
        selectView!.addSubview(actionBtn(size.width,title: title))
//        selectView!.addSubview(actionUIPickView(CGSize(width: size.width, height: self.pickerHeight)))
        actionUIPickView(CGSize(width: size.width, height: self.pickerHeight)).forEach { (subview) in
            selectView!.addSubview(subview)
        }
        
        return selectView!
    }
    
    open func showInView(_ contrller: UIViewController,didCilickOk:@escaping(([Any])->Void)) {
        self.showInView(Title:"", contrller: contrller, didCilickOk: didCilickOk)
    }
    
    open func showInView(_ title:String,contrller: UIViewController,didCilickOk:@escaping (([String:Any])->Void)){
        if self.dataSoure == nil{
            return
        }
        self.controller = contrller
        self.didClickDict = didCilickOk
        self.setUIStayle(contrller)
    }
    
    open func showInView(Title title:String,contrller: UIViewController,didCilickOk:@escaping (([Any])->Void)) {
        if self.dataSoure == nil{
            return
        }
        self.controller = contrller
        self.didClick = didCilickOk
        self.setUIStayle(contrller)
    }
    
    fileprivate func setUIStayle(_ contrller:UIViewController){
        self.addSubview(createSelectView(CGSize(width: UIScreen.main.bounds.size.width, height: self.pickerHeight + 44),title: title))
        self.setupInitPostion()
        
        let toolBarYpostion = UIScreen.main.bounds.size.height - (self.pickerHeight + self.toolBar!.frame.size.height)
        
        UIView.animate(withDuration: 0.24, animations: { () -> Void in
            self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
            contrller.view.tintAdjustmentMode = UIViewTintAdjustmentMode.dimmed
            contrller.navigationController?.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentMode.dimmed
            self.selectView!.frame = CGRect(x: 0, y: toolBarYpostion, width: self.selectView!.frame.size.width, height: self.selectView!.frame.size.height)
            }, completion: nil)
    }
    
    open func dismiss(_ controller:UIViewController){
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.backgroundColor = UIColor.clear
            controller.view.tintAdjustmentMode = UIViewTintAdjustmentMode.normal
            controller.navigationController?.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentMode.normal
            for (_,value) in self.subviews.enumerated() {
                value.frame = CGRect(x: value.frame.origin.x, y: UIScreen.main.bounds.height, width: value.frame.size.width, height: value.frame.size.height)
            }
        }, completion: { (bol) -> Void in
            self.removeFromSuperview()
        }) 
    }
    
    func setupInitPostion(){
        UIApplication.shared.keyWindow?.addSubview(self)
        self.superview?.bringSubview(toFront: self)
    }
    
    func cancelBtnClick(){
        self.groupDelegate?.didCancelView()
        self.dismiss(self.controller!)
    }
    
    func doneBtnClick(){
        if self.dataSoure == nil || self.dataSoure?.count == 0 {
            return
        }
        var selectArray:[Any] = []
        var selects:[String:Any] = [:]
        for i in 0..<self.dataSoure!.count {
            let index = self.pickViews[i].selectedRow(inComponent: 0)
            let curModel = self.dataSoure![i]
            selectArray.append(curModel.Sourece![index])
            selects[curModel.Key] = curModel.Sourece![index]
        }
        self.didClick?(selectArray)
        self.didClickDict?(selects)
        self.groupDelegate?.GciPickerView(didSelectOk: selects)
        self.dismiss(self.controller!)
    }
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSoure![pickerView.tag].Sourece!.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let curModel = self.dataSoure![pickerView.tag]
        let indexpaht = IndexPath(row: row, section: pickerView.tag)
        return self.showTitle!(curModel.Key,curModel.Sourece![row],indexpaht)
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let curModel = self.dataSoure![pickerView.tag]
        self.groupDelegate?.GciPickerView(pickerView,didSelectRow: row, Inkey: curModel.Key, obj: curModel.Sourece![row])
    }
    
    open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let curModel = self.dataSoure![pickerView.tag]
        let indexpaht = IndexPath(row: row, section: pickerView.tag)
        let cgrect = CGRect(x: 12, y: 0.0, width: pickerView.rowSize(forComponent: component).width - 12, height: pickerView.rowSize(forComponent: component).height + 100)
        let label:UILabel = UILabel(frame: cgrect)
        label.text = self.showTitle!(curModel.Key,curModel.Sourece![row],indexpaht)
        label.font = self.font
        label.textAlignment = .center
        label.textColor = ViewUitl.getUIColorByHex(red: 0x48, green: 0x48, blue: 0x48, alpha: 1)
        return label
    }
    
    
    open func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.rowHeight
    }
    
}

public struct GciPickerItem {
    public init(Key:String,Sourece:[Any]?){
        self.Key = Key
        self.Sourece = Sourece
    }
    
    public var Key:String!
    public var Sourece:[Any]?
}

public protocol GciGropViewDelegate : NSObjectProtocol {
    func GciPickerView(_ pickerView:UIPickerView,didSelectRow row:Int,Inkey inkey:String,obj:Any)
    func GciPickerView(didSelectOk selectdata:[String:Any])
    func didCancelView()
}
