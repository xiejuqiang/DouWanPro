//
//  NewsListViewController2.h
//  MainFra
//
//  Created by Tang silence on 13-6-24.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class Function;
@class RecordDao;
@class UrlStr;
@class JsonParser;
@interface NewsList2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_mTableView;
    float windowHeight;
    Function *function;
    MBProgressHUD *HUD;
    UrlStr *urlStr;
    
    int  pageNum;  //当前显示页数
    JsonParser *jsonParser;
    RecordDao *recordDB;
    NSMutableArray *categoryArray;
    NSMutableArray *newsListArray;
    UIScrollView *categoryTitleView;
    
    int step; //1 获取category   2  获取具体列表
}
@property (nonatomic,retain)NSMutableArray *listArray;
@property (nonatomic)int frameworkflag;
@property (nonatomic,retain)NSString *default_url;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;
@end
