//
//  GciSound.swift
//  GciUnit
//
//  Created by 黄超 on 16/10/19.
//  Copyright © 2016年 黄超. All rights reserved.
//

import UIKit
import AudioToolbox

open class GciSound: NSObject {
    fileprivate var mSoundId = kSystemSoundID_Vibrate
    var mAction:() -> Void = {}
    
    public init(SystemFile sysfile:String) {
        super.init()
        let path = "/System/Library/Audio/UISounds/\(sysfile).caf"
        let url = URL(fileURLWithPath:path)
        var theSoundID:SystemSoundID = 0
        let error = AudioServicesCreateSystemSoundID(url as CFURL, &theSoundID)
        if error == kAudioServicesNoError {
            mSoundId = theSoundID
        }
    }
    
    public init(FilePath path:String) {
        super.init()
        let url = URL(fileURLWithPath:path)
        var theSoundID:SystemSoundID = 0
        let error = AudioServicesCreateSystemSoundID(url as CFURL, &theSoundID)
        if error == kAudioServicesNoError {
            mSoundId = theSoundID
        }
    }
    
    //震动
    open static func PlayVibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
    }
    
    //声音
    open func play() {
        AudioServicesPlaySystemSound(mSoundId)
    }
    
    //声音振动
    open func playAlter() {
        AudioServicesPlayAlertSound(mSoundId)
    }
    
    //循环声音
    open func playAlertAndCompletionAction() {
        AudioServicesAddSystemSoundCompletion(mSoundId, nil, nil, { (sounid, pointer) in
            AudioServicesPlaySystemSound(sounid)
        }, nil)
        AudioServicesPlaySystemSound(mSoundId)
    }
    
    //循环震动
    open func playVibrateAndCompletionAction() {
        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate), nil, nil, { (sounid, pointer) in
            AudioServicesPlayAlertSound(sounid)
        }, nil)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    //循环声音振动
    open func playAlterVibrateAndCompletionAction() {
        AudioServicesAddSystemSoundCompletion(mSoundId, nil, nil, { (sounid, pointer) in
            AudioServicesPlayAlertSound(sounid)
        }, nil)
        AudioServicesPlayAlertSound(mSoundId)
    }
    
    //停止声音震动
    open func stopPlay() {
        AudioServicesRemoveSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesRemoveSystemSoundCompletion(mSoundId)
    }
    
    deinit {
        AudioServicesRemoveSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesRemoveSystemSoundCompletion(mSoundId)
        AudioServicesDisposeSystemSoundID(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesDisposeSystemSoundID(mSoundId)
    }
}
