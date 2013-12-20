//
//  FeedBackListViewController.h
//  MainFrame
//
//  Created by apple on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableView;
}

@property (nonatomic, retain) NSArray *returnDataArray;//返回数据信息

@end
