//
//  BaseViewController.swift
//  JKUnit
//
//  Created by jackyshan on 2017/5/26.
//  Copyright © 2017年 jackyshan. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    var didSetupConstraints = false
    var didSystemAutoLayout = false
    var didAnimateComplete = false
    
    // MARK: - 生命周期
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if DEBUG
            if let appIdx = self.getClassName().range(of: Tools.BundleName)?.upperBound {
                Log.i("进入页面"+NSStringFromClass(self.classForCoder).substring(from: appIdx))
            }
        #endif
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAnimateComplete {
            didViewAnimateComplete()
            didAnimateComplete = true
        }
        
        #if DEBUG
            if let appIdx = self.getClassName().range(of: Tools.BundleName)?.upperBound {
                Log.i("离开页面"+NSStringFromClass(self.classForCoder).substring(from: appIdx))
            }
        #endif
    }
    
    deinit {
        #if DEBUG
            if let appIdx = self.getClassName().range(of: Tools.BundleName)?.upperBound {
                Log.i("销毁页面"+self.getClassName().substring(from: appIdx))
            }
        #endif
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        if !didSetupConstraints {
            didSnpKitUiLoad()
            didSetupConstraints = true
        }
    }
    
    open override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        if !didSystemAutoLayout{
            didSystemAutoLayoutComplete()
            didSystemAutoLayout = true
        }
    }
    
    open func didViewAnimateComplete(){ }
    open func didSnpKitUiLoad() -> Void{}
    open func didSystemAutoLayoutComplete() -> Void{}

    // MARK: - navigation相关
    open func showLeftButton(_ colorImage: UIImage = NavigationTool.navBlackBackImage ?? NavigationTool.navClearImage) {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(colorImage, for: UIControlState())
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.adjustsImageWhenHighlighted = false
        let leftBtnItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.addTarget(self, action: #selector(self.backBtnAction), for: .touchUpInside)
        
        let leftBtn1 = UIButton(type: .custom)
        leftBtn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn1.addTarget(self, action: #selector(self.backBtnAction), for: .touchUpInside)
        let leftBtnItem1 = UIBarButtonItem.init(customView: leftBtn1)
        self.navigationItem.setLeftBarButtonItems([leftBtnItem, leftBtnItem1], animated: false)
    }
    
    open func showRightButton(_ colorImage: UIImage = NavigationTool.navClearImage) {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(colorImage, for: UIControlState())
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightBtn.adjustsImageWhenHighlighted = false
        let rightBtnItem = UIBarButtonItem(customView: rightBtn)
        rightBtn.addTarget(self, action: #selector(self.rightBtnAction), for: .touchUpInside)
        self.navigationItem.setRightBarButton(rightBtnItem, animated: false)
    }
    
    open func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    open func rightBtnAction() {
        
    }
    
    open func showWriteNavController() {
        self.navigationController?.navigationBar.setBackgroundImage(NavigationTool.navWhiteImage, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    open func showClearNavController() {
        self.navigationController?.navigationBar.setBackgroundImage(NavigationTool.navClearImage, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    open func showCustomNavController(_ colorImage: UIImage, _ titleColor: UIColor = UIColor.white) {
        self.navigationController?.navigationBar.setBackgroundImage(colorImage, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor]
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
