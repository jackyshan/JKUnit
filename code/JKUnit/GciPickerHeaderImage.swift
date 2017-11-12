//
//  GciPickerHeaderImage.swift
//  rentStudent
//
//  Created by 黄超 on 16/6/23.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit

open class GciPickerHeaderImage: NSObject,VPImageCropperDelegate {
    fileprivate var picker:GciPickerImage!
    fileprivate var mAction:((UIImage)->Void)?
    fileprivate var mCancel:(()->Void)?
    fileprivate var mSize:CGSize!
    
    open func picker(_ width:CGFloat,height:CGFloat,contoller: UIViewController!,action:@escaping (UIImage)->Void,cancel:(()->Void)?){
        self.mSize = CGSize(width: width, height: height)
        self.mAction = action
        self.mCancel = cancel
        picker = GciPickerImage()
        picker.picker(contoller, action: {[weak self] (image) -> Void in
            let x = (contoller.view.frame.width - width) / 2
            let y = (contoller.view.frame.height - height) / 2 - 60
            let vc = VPImageCropperViewController(image: image, cropFrame: CGRect(x: x, y: y, width: width, height: height), limitScaleRatio: 3)
            vc?.delegate = self!
            contoller.present(vc!, animated: false, completion: nil)
            }, cancel: nil)
        
    }
    
    open func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        let image = GciImageTool.ScaleImage(editedImage,size: mSize)
        self.mAction?(image)
        cropperViewController.dismiss(animated: true) { () -> Void in
            
        }
    }
    
    open func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismiss(animated: true) { () -> Void in
            self.mCancel?()
        }
        
    }
}
