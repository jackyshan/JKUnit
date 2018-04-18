//
//  GciNavAlert.swift
//  rentStudent
//
//  Created by 黄超 on 16/6/15.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

open class GciNavAlert: UIAlertView,UIAlertViewDelegate {
    fileprivate var data:Any?
    fileprivate var action:((_ send:UIAlertView?)->Void)?
    fileprivate var actions:((_ send:UIAlertView?,_ index:Int?)->Void)?
    public init(title:String!,message:String!,btnMessage:String!,action:((_ send:UIAlertView?)->Void)?){
        super.init(frame: CGRect.zero)
        self.title = title
        self.message = message
        self.delegate = self
        self.addButton(withTitle: btnMessage)
        self.action = action;
    }
    
    public init(title:String!,message:String!,btnMessages:[String]!,action:((_ send:UIAlertView?,_ index:Int?)->Void)?){
        super.init(frame: CGRect.zero)
        self.actions = action
        self.title = title
        self.message = message
        self.delegate = self
        for item in btnMessages {
            self.addButton(withTitle: item)
        }
    }
    
    open func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.action?(self)
        self.actions?(self, buttonIndex)
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
