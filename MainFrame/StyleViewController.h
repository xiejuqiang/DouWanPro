//
//  StyleViewController.h
//  CoverStyle
//
//  Created by apple on 13-7-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordDao;
@class UrlStr;
@class JsonParser;
@class HotNewsView;
@interface StyleViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *coverScroll;
    UIImageView *imageView;
    UITableView *menuTableView;
    UIPageControl *pageControl;
    NSTimer *timer;
    int TimeNum;
    BOOL Tend;
    NSMutableArray *thumbArray;
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    HotNewsView *hotNewsView;
    
    NSArray *listArray;
}
//@property (nonatomic,retain) NSMutableArray *viewArray; //跳转VC数组
@property (nonatomic,retain) NSArray *systemSettingArray; //系统配置

//@property (nonatomic,retain) NSMutableDictionary *menuPicNameArr; //图片名称数组
//@property (nonatomic,retain) NSMutableDictionary *menuNameArr; //功能名称数组

@property (nonatomic,retain) NSMutableDictionary *menuAttributeArray;

@property (nonatomic,retain) NSMutableArray *proArray;
@end
