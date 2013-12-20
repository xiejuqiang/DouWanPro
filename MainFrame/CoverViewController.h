//
//  CoverViewController.h
//  FrameOfDemo
//
//  Created by apple on 13-7-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotNewsView.h"
@class RecordDao;
@class UrlStr;
@class JsonParser;
@class HotNewsView;
@interface CoverViewController : UIViewController<UIScrollViewDelegate,NSURLConnectionDelegate,HotNewsDelegate>
{
    UIScrollView *coverScroll;
    UIScrollView *menuScroll;
    UIImageView *imageView;
    UIPageControl *pageControl;
    NSTimer *timer;
    int TimeNum;
    BOOL Tend;
    NSArray *pointArr;
    NSArray *labelArr;
    
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    HotNewsView *hotNewView;
    NSArray *listArray;
    NSMutableArray *thumbArray;
}
//公有
@property (nonatomic,retain)NSString *aboutMeUrl;
@property (nonatomic) int frameworkflag;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;
//私有
@property(nonatomic, retain) NSMutableArray *proArray;
@property(nonatomic, retain) NSMutableData *receiveData;
//@property (nonatomic,retain) NSMutableArray *viewArray; //跳转VC数组

@property (nonatomic,retain) NSArray *systemSettingArray; //系统配置

//@property (nonatomic,retain) NSMutableDictionary *btnPicNameArr;
//@property (nonatomic,retain) NSMutableDictionary *labelNameArr;

@property (nonatomic,retain) NSMutableDictionary *menuAttributeArray;


@end
