//
//  MoreViewController.h
//  MainFrameSY
//
//  Created by Tang silence on 13-7-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class About;
@class FeedBack;
@class CodeViewController;
@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mTableView;
    float windowHeight;
    NSMutableArray *nameArray;
    UIColor *navigationColor;
    
    About *aboutObj;
    FeedBack *feedBackObj;
    CodeViewController *codeVC;
}
@property (nonatomic)int frameworkflag;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;
@property (nonatomic,retain)NSString *default_url;

@end
