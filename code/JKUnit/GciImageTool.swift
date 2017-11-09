//
//  GciImageTool.swift
//  rentStudent
//
//  Created by 黄超 on 16/5/17.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

public class GciImageTool {
    public static func ClearImage(_ size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    public static func ColorImage(_ size:CGSize,color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        let v = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        v.backgroundColor = color
        v.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    public static func ScaleImage(_ image:UIImage,size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    /** 通过数据生成一个二维码 */
    public static func CreateUIImageByCIIImage(image:CIImage,width:CGFloat,height:CGFloat) -> UIImage? {
        var result:UIImage? = nil
        let extent = image.extent.integral
        let scale = min(width / extent.width, height / extent.height)//UIScreen.mainScreen().scale
        // 创建bitmap;
        let width = Int(extent.width * scale)
        let height = Int(extent.height * scale)
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let context = CIContext(options:nil)
        if bitmapRef != nil {
            let bitmapImage = context.createCGImage(image, from: extent)
            if bitmapImage != nil {
                bitmapRef!.interpolationQuality = .none
                bitmapRef!.scaleBy(x: scale, y: scale)
                bitmapRef!.draw(bitmapImage!, in: extent)
                // 保存bitmap到图片
                let scaledImage = bitmapRef!.makeImage()
                result = UIImage(cgImage: scaledImage!)
            }
        }
        return result
    }
    
    public static func IconByFont(_ text:String!,fontfamily:String?,size:CGSize,color:UIColor?) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if fontfamily != nil {
        label.font = UIFont(name: fontfamily!, size: size.width)
        }else{
        label.font = UIFont.systemFont(ofSize: size.width)
        }
        label.text = text
        label.textColor = color
        label.drawText(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //retainWeakReference()
        return result
    }
    
    public static func ThumbnailWithImageWithoutScale(_ image:UIImage!,asize:CGSize) -> UIImage{
        let oldsize = image.size
        var rect:CGRect = CGRect.zero
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        return ScaleImage(image, size: asize)
    }
}
