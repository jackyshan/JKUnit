//
//  MBHudHelper.m
//  xxd
//
//  Created by jackyshan on 16/7/25.
//  Copyright © 2016年 baitrading. All rights reserved.
//

#import "MBHudHelper.h"
#import "MBProgressHUD.h"

@implementation MBHudHelper

+ (void)showSuccText:(NSString *)text {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:1.f];
}

+ (void)showErrorText:(NSString *)text {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:1.f];
}

@end
