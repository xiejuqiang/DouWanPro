//
//  MainFramDragViewController.h
//  MainFramDragViewController
//
//  Created by Tang silence on 13-6-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class testV;

@interface MainFramDragViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    float windowHeight;
    BOOL isAppear;
    CGPoint startPoint;
}
@property (retain ,nonatomic) UITableView *listView;
@property (retain ,nonatomic) UIView *drawerView;
@property (retain ,nonatomic) UINavigationBar *navBar;

@property(nonatomic,retain)NSString *aboutMeUrl;
@property (retain ,nonatomic) NSArray *list;
//@property (nonatomic) int frameworkflag;
@property (nonatomic,retain)NSMutableArray *viewArray;
@end
