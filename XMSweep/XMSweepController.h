//
//  XMSweepController.h
//  XMSweep
//
//  Created by Kenfor-YF on 16/5/21.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMSweepController : UIViewController
typedef void (^XMSweepBlock)(NSString *result);
@property(nonatomic,copy)XMSweepBlock didRecoiveBlock;
-(void)setDidRecoiveBlock:(XMSweepBlock)didRecoiveBlock;

@end
