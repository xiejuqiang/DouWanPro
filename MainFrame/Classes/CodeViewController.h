//
//  CodeViewController.h
//  MainFrame
//
//  Created by Tang silence on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "./ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"

@interface CodeViewController : UIViewController<UIAlertViewDelegate >
{
    UILabel *msgLab;  //监测到二维码信息
    UILabel *contentLab;  //二维码内容
    UITextField *text;    //
    UIImageView *imageview;  //二维码截图
    UIButton *scanBtn;  //扫描
    UIButton *openBtn; //打开
}
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
- (void)button:(id)sender;
- (void)button2:(id)sender;
- (void)Responder:(id)sender;
@end
