//
//  FeedBack.h
//  FeedBack
//
//  Created by Tang silence on 13-6-20.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class UrlStr;
@class RecordDao;
@class JsonParser;
@class CustomTextField;
@interface FeedBack : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    float windowHeight;
    MBProgressHUD *HUD;   //提示款显示对象
    UITextView *_myTextV; //输入内容框
    CustomTextField *_userName;
    CustomTextField *_telNumber;
    UrlStr *urlStr;
    id _jsonArray;
    UIButton *postBtn;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    NSArray *listArray;//存解析后的数组
}
@property(nonatomic,retain)NSString *postUrl;
@property (nonatomic) int frameworkflag;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;
@property (nonatomic, retain)NSString *returnString;

@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败
@end
