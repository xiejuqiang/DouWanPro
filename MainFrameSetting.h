//
//  MainFrameSetting.h
//  MainFra
//
//  Created by Tang silence on 13-6-21.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

#define homeModel 0
@class AppDelegate;
@class RecordDao;
@class UrlStr;
@class MenuAttribute;
enum {
    Layout = 0,
    MoNews = 1,
    MoProduct = 2,
    MoPicture = 3,
    MoMessage = 4,
    MoContact = 5,
    MoProfile = 6,
    MoQrcode = 7
};

@interface MainFrameSetting : NSObject
{
    AppDelegate *_myDelegate;
    NSMutableArray *systemCofigDBArray; //系统配置数据库读取到的数组
    
    UIColor *navigationColor;
    RecordDao *recordDB;
    NSArray *allFramArray;
    int layout_flag;
    UrlStr *urlStr;
    MenuAttribute *menuAttribute;
    UINavigationController *newsList1NaC;
    UINavigationController *produce1NaC;
    UINavigationController *aboutMeNaC;
//    NSMutableDictionary *menuNameArr; //模板首页名称数组
//    
//    
//    NSMutableDictionary *menuStylePicNameArr; //模板列表首页图片数组
//    NSMutableDictionary *menuCoverPicNameArr; //模板按钮首页图片数组
}
@property (nonatomic,retain) NSArray *systemSettingArray;
//@property (nonatomic,retain) NSDictionary *systemSettingDic;
@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败

- (void)openUI;
@end
