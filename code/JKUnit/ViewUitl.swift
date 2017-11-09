//
//  ViewUitl.swift
//  rentStudent
//
//  Created by 黄超 on 16/5/25.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

open class ViewUitl: NSObject {
    open static func showLoadingInView(_ view:UIView,alpha:CGFloat = 1){
        hideLoadingInView(view)
        
        let activityView:UIView = UIView(frame:CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        //activityView.alpha = alpha
        activityView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
        let activiy:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //activiy.center = CGPoint(x: activityView.frame.size.width / 2, y: activityView.frame.size.height / 2)
        activiy.activityIndicatorViewStyle = .gray
        activiy.startAnimating()
        activityView.addSubview(activiy)
        activiy.snp_makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
        
        activityView.tag = 1001
        view.addSubview(activityView)
        
        activityView.snp_makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }

    }
    
    open static func hideLoadingInView(_ view:UIView){
        var vs:[UIView] = []
        for i in 0..<view.subviews.count {
            if view.subviews[i].tag == 1001 {
                vs.append(view.subviews[i])
            }
        }
        
        vs.forEach { (v) in
            v.removeFromSuperview()
        }
    }
    
    public static func colorWithHexString(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    open static func getUIColorByHex(red r:CGFloat,green g:CGFloat,blue b:CGFloat,alpha a:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
    
    static func getCShareDateTimeString(_ date:String) -> String{
        return date.replacingOccurrences(of: "T", with: " ")
    }
    
    static func getDateByCShareString(_ date:String,dateFormat:String) -> Date? {
        let format:DateFormatter = DateFormatter()
        format.dateFormat = dateFormat
        return format.date(from: getCShareDateTimeString(date))
    }
    
    static func subString(_ str:String,len:Int) -> String {
        var result = ""
        if str.characters.count >= len {
            result = (str as NSString).substring(to: len)
        }else{
            result = str
        }
        return result
    }
    
    private static var gciBundle:Bundle? = nil
    public static func getResourceFromBunlde(filename:String,suffix:String) -> String? {
        var result:String? = nil
        if gciBundle == nil {
            let strResourcesBundle = Bundle.main.path(forResource: "GciUnit", ofType: "bundle")
            if strResourcesBundle != nil {
                gciBundle = Bundle(path:strResourcesBundle!)
            }
        }
        
        if gciBundle != nil {
            result = gciBundle?.path(forResource: filename, ofType: suffix)
        }
        
        return result
    }
    
}
