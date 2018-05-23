//
//  GciPickerImage.swift
//  rentStudent
//
//  Created by 黄超 on 16/6/22.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit
import MobileCoreServices

open class GciPickerImage: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    fileprivate var mAction:((UIImage?)->Void)?
    fileprivate var mCancel:(() -> Void)?
    fileprivate var sheet:GciUIActionSheet<PickType>!
    
    open func picker(_ contoller:UIViewController!,action:@escaping ((_ image:UIImage?)->Void),cancel:(()->Void)?){
        self.mAction = action
        self.mCancel = cancel
        sheet = GciUIActionSheet<PickType>()
        sheet.setDataSoure([PickType(id: 0, name: "Camera"),PickType(id: 1, name: "Photo")]) { (obj) -> String in
            return obj.name
        }
        sheet.showInView("Choose", view: contoller.view) {[weak self] (obj) -> Void in
            switch obj.id {
            case 0:
                let imagevc = UIImagePickerController()
                imagevc.delegate = self
                imagevc.sourceType = .camera
                if self!.isFrontCameraAvailable() {
                    imagevc.cameraDevice = .front
                }
                var mediaTypes = Array<String>()
                mediaTypes.append(String(kUTTypeImage))
                imagevc.mediaTypes = mediaTypes
                contoller.present(imagevc, animated: true, completion: nil)
                break
            case 1:
                let imagevc = UIImagePickerController()
                imagevc.delegate = self
                imagevc.sourceType = .photoLibrary
                var mediaTypes = Array<String>()
                mediaTypes.append(String(kUTTypeImage))
                imagevc.mediaTypes = mediaTypes
                contoller.present(imagevc, animated: true, completion: nil)
                break
            default:
                break
            }
            
        }
    }
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    }
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let infodic:NSDictionary = info as NSDictionary
        //获取键值UIImagePickerControllerMediaType的值，表示了当前处理的是视频还是图片
        let mediaType = infodic["UIImagePickerControllerMediaType"] as! String
        //如果是视频的话
        if mediaType == kUTTypeMovie as String{
            // saveMovie(infodic)
        }
        else if mediaType == kUTTypeImage as String{
            //拍摄的原始图片
            let originalImage:UIImage?
            //用户修改后的图片（如果allowsEditing设置为True，那么用户可以编辑）
            let editedImage:UIImage?
            //最终要保存的图片
            let savedImage:UIImage?
            
            //从字典中获取键值UIImagePickerControllerEditedImage的值，它直接包含了图片数据
            editedImage = infodic["UIImagePickerControllerEditedImage"] as? UIImage
            //从字典中获取键值UIImagePickerControllerOriginalImage的值，它直接包含了图片数据
            originalImage = infodic["UIImagePickerControllerOriginalImage"] as? UIImage
            
            //判断是否有编辑图片，如果有就使用编辑的图片
            if (editedImage != nil){
                savedImage = editedImage
            }else{
                savedImage = originalImage
            }
            
            picker.dismiss(animated: false) { () -> Void in
                self.mAction?(savedImage)
            }
        }
    }
    
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.mCancel?()
        picker.dismiss(animated: true, completion: nil)
    }
    
    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    open func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    open func isRearCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.rear)
    }
    
    open func isFrontCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.front)
    }
    
    open func doesCameraSupportTakingPhotos() -> Bool {
        let availableMediaTypes:NSArray = UIImagePickerController.availableMediaTypes(for: .camera)! as NSArray
        return availableMediaTypes.contains(kUTTypeImage)
    }
    
    open func isPhotoLibraryAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    open func canUserPickVideosFromPhotoLibrary() -> Bool{
        let availableMediaTypes:NSArray = UIImagePickerController.availableMediaTypes(for: .photoLibrary)! as NSArray
        return availableMediaTypes.contains(kUTTypeMovie)
    }
    
    open func canUserPickPhotosFromPhotoLibrary() -> Bool {
        let availableMediaTypes:NSArray = UIImagePickerController.availableMediaTypes(for: .photoLibrary)! as NSArray
        return availableMediaTypes.contains(kUTTypeImage)
    }
    
}

public struct PickType{
    var id:Int!
    var name:String!
}
