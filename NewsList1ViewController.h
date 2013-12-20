//
//  NewsListViewController1.h
//  MainFra
//
//  Created by Tang silence on 13-6-24.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class RecordDao;
@class UrlStr;
@class JsonParser;

@interface NewsList1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_mTableView;
    float windowHeight;
    int  pageNum;  //当前显示页数
    
    MBProgressHUD *HUD;
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    NSArray *listArray;
    
    NSMutableArray *categoryArray;
    NSMutableArray *newsListArray;
    
    int step; //1 获取category   2  获取具体列表
}


@property (nonatomic)int frameworkflag;
@property (nonatomic,retain)NSString *default_url;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;

@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败


@end
