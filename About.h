//
//  About.h
//  About
//
//  Created by Tang silence on 13-6-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface About : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
{
    UIWebView *mWebView;
    float windowHeight;
    MBProgressHUD *HUD;
    BOOL isAppear;
    CGPoint startPoint;
}
@property (nonatomic,retain)NSString *aboutMeUrl;
@property (nonatomic) int frameworkflag;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;

@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败

//@property (nonatomic,retain) id myDelegate;
- (void)showWithLabel;
- (void)myTask;
@end
