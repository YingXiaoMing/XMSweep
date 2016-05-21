//
//  ViewController.m
//  XMSweep
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "XMSweepController.h"
#import <AVFoundation/AVFoundation.h>
#define isDevice_IOS8 ([[[UIDevice currentDevice]systemVersion]intValue] >=8)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.frame = CGRectMake(0, 0, 160, 44);
    btn.center = self.view.center;
    [btn setTitle:@"进入扫码功能" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnClick
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusDenied) {//关闭系统权限
        if (isDevice_IOS8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机访问受限" message:@"请在IPhone的\"设置->隐私->相机\"选项中,允许\"XMSweep\"访问你的照相机." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self canOpenSystemSettingView]) {
                    [self systemSettingView];
                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"相机访问受限" message:@"请在IPhone的\"设置->隐私->相机\"选项中,允许\"XMSweep\"访问你的照相机." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
        return;
    }
    XMSweepController *sweepVC = [[XMSweepController alloc]init];
    sweepVC.view.alpha = 0;
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window.rootViewController addChildViewController:sweepVC];
    [appdelegate.window.rootViewController.view addSubview:sweepVC.view];
    [sweepVC setDidRecoiveBlock:^(NSString *result) {
        NSLog(@"%@",result);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        sweepVC.view.alpha = 1;
    }];
    
}
-(BOOL)canOpenSystemSettingView{
    if (isDevice_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            return YES;
        }else {
            return NO;
        }
    }else{
        return NO;
    }
}
-(void)systemSettingView{
    if (isDevice_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}
@end
