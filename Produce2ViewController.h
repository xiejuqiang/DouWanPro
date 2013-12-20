//
//  ProduceViewController2.h
//  MainFrame
//
//  Created by Tang silence on 13-6-28.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface Produce2ViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,MBProgressHUDDelegate>
{
    float windowHeight;
    UIScrollView *imgscrollview;
    MBProgressHUD *HUD;
    BOOL minFlag,maxFlag; //标志是否是第一张 最后一张
    int nowPicIndex;
}
@property (nonatomic,retain)NSMutableArray *listArray;
@property (nonatomic)int frameworkflag;
@property (nonatomic,retain)UIColor *navigationColor;
@property (nonatomic,retain)NSString *navigationTitle;
@property (nonatomic) int framework_1_height_int;
@property (nonatomic) int framework_2_height_int;
@property (nonatomic) int framework_2_defaultX_int;
@property (nonatomic,retain)NSString *default_url;
@end
