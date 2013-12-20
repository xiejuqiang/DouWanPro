//
//  Product1CategoryViewController.h
//  MainFrameSY
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class UrlStr;
@class JsonParser;
@class RecordDao;
@interface Product1CategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_mTableView;
    MBProgressHUD *HUD;
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
}
@property(nonatomic,retain) NSArray *categoryData;

@end
