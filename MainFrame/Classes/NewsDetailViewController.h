//
//  NewsDetailViewController.h
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../MBProgressHUD.h"

@class RecordDao;
@class UrlStr;
@class JsonParser;

@interface NewsDetailViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
{    
    float windowHeight;
    
    MBProgressHUD *HUD;
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    NSArray *listArray;
    @private
    UILabel *titleLabel;
    UILabel *dateTime;
    UILabel *fromLabel;
    UIWebView *descripWebView;
    UIImageView *pic;
    
    NSString *commentNumString; //判断评论得数目
}
@property (nonatomic,retain) NSString *nid;

@property (nonatomic)int frameworkflag;
@property (nonatomic,retain)NSString *default_url;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;

@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败
@end
