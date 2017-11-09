//
//  GciUIView.swift
//  rentStudent
//
//  Created by 黄超 on 16/5/17.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

@IBDesignable
open class GciUIView: UIView {
    @IBInspectable open var border:CGFloat = 0
    @IBInspectable open var border_left:CGFloat = 0
    @IBInspectable open var border_right:CGFloat = 0
    @IBInspectable open var border_top:CGFloat = 0
    @IBInspectable open var border_bottom:CGFloat = 0
    @IBInspectable open var borderColor:UIColor = UIColor.black
    @IBInspectable open var borderColor_left:UIColor = UIColor.black
    @IBInspectable open var borderColor_right:UIColor = UIColor.black
    @IBInspectable open var borderColor_top:UIColor = UIColor.black
    @IBInspectable open var borderColor_bottom:UIColor = UIColor.black
    
    @IBInspectable open var border_top_padding:CGFloat = 0
    @IBInspectable open var border_bottom_padding:CGFloat = 0
    
    @IBInspectable open var border_left_padding:CGFloat = 0
    @IBInspectable open var border_right_padding:CGFloat = 0
    
    var ctx:CGContext?
    
    open var ShowTap:Bool = false
    
    var curBackColor:UIColor? = nil
    
    fileprivate var mClickListenter:((_ view:GciUIView) -> Void)?
    var tap:UITapGestureRecognizer?
    
   open override func draw(_ rect: CGRect) {
        super.draw(rect)
        ctx = UIGraphicsGetCurrentContext()
        if border != 0 {
            drawLine(border, color: borderColor, boderPoint: .left)
            drawLine(border, color: borderColor, boderPoint: .top)
            drawLine(border, color: borderColor, boderPoint: .right)
            drawLine(border, color: borderColor, boderPoint: .bottom)
            ctx?.strokePath()
            return
        }
        
        if border_left != 0 {
            drawLine(border_left, color: borderColor_left, boderPoint: .left)
            ctx!.strokePath()
        }
        
        if border_right != 0 {
            drawLine(border_right, color: borderColor_right, boderPoint: .right)
            ctx!.strokePath()
        }
        
        if border_top != 0 {
            drawLine(border_top, color: borderColor_top, boderPoint: .top)
            ctx!.strokePath()
        }
        
        if border_bottom != 0 {
            drawLine(border_bottom, color: borderColor_bottom, boderPoint: .bottom)
            ctx!.strokePath()
        }
    }
    
    fileprivate func drawLine(_ width:CGFloat,color:UIColor,boderPoint:BorderPoint) -> Void{
        let ciColor:CIColor = CIColor(color: color)
        ctx!.setLineWidth(width)
        ctx!.setLineCap(CGLineCap.butt)
        ctx!.setStrokeColor(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: 1.0)
        let centerLinePointX = CGFloat(Int(width / 2))
        let centerLintPointY = CGFloat(Int(width / 2))
        switch(boderPoint){
        case BorderPoint.left:
            ctx!.move(to: CGPoint(x: centerLinePointX, y: border_top))
            ctx!.addLine(to: CGPoint(x: centerLinePointX, y: self.bounds.height - border_bottom_padding))
            break
        case BorderPoint.right:
            ctx!.move(to: CGPoint(x: self.bounds.width - centerLinePointX, y: border_top_padding))
            ctx!.addLine(to: CGPoint(x: self.bounds.width - centerLinePointX, y: self.bounds.height - border_bottom_padding))
            break
        case BorderPoint.top:
            ctx!.move(to: CGPoint(x: border_left_padding, y: centerLintPointY))
            ctx!.addLine(to: CGPoint(x: self.bounds.width - border_right_padding, y: centerLintPointY))
            break
        case BorderPoint.bottom:
            ctx!.move(to: CGPoint(x: border_left_padding, y: self.bounds.height - centerLintPointY))
            ctx!.addLine(to: CGPoint(x: self.bounds.width - border_right_padding, y: self.bounds.height - centerLintPointY))
            break
        }
    }
    
    func reloadUi(){
         ctx!.strokePath()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if ShowTap{
            curBackColor = backgroundColor
            backgroundColor = UIColor.groupTableViewBackground
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if ShowTap{
            UIView.animate(withDuration: 0.15, animations: { () -> Void in
                self.backgroundColor = self.curBackColor
            })
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if ShowTap{
            UIView.animate(withDuration: 0.15, animations: { () -> Void in
                self.backgroundColor = self.curBackColor
            })
        }
    }
    
    open func setClickListenter(_ action:((_ view:GciUIView) -> Void)?){
        self.mClickListenter = action
        if tap == nil {
            tap = UITapGestureRecognizer(target: self, action: #selector(GciUIView.onClickListenter))
            self.addGestureRecognizer(self.tap!)
        }
    }
    
    open func onClickListenter(){
        self.mClickListenter?(self)
    }
    
    open func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = GciUITapGestureRecognizer(target: target, action: action)
        gr.TagetName = "Click"
        gr.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gr)
    }
    
    open func removeClickListener() {
        if self.gestureRecognizers != nil {
            for item in self.gestureRecognizers! {
                if item is GciUITapGestureRecognizer && (item as! GciUITapGestureRecognizer).TagetName == "Click" {
                    self.removeGestureRecognizer(item)
                    return
                }
            }
        }
    }
}

public class GciUITapGestureRecognizer : UITapGestureRecognizer {
    public var TagetName = ""
}

enum BorderPoint: Int{
    case left,top,right,bottom
}
