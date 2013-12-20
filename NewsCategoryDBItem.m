//
//  CategoryDBItem.m
//  MainFrame
//
//  Created by Tang silence on 13-7-3.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsCategoryDBItem.h"

@implementation NewsCategoryDBItem

@synthesize catid;
@synthesize catname;
@synthesize modelid;
//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.catid = [dataArray objectAtIndex:0];
    self.catname = [dataArray objectAtIndex:1];
    self.modelid = [dataArray objectAtIndex:2];
}
@end
