//
//  ProduceCategoryDBItem.m
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "ProduceCategoryDBItem.h"

@implementation ProduceCategoryDBItem

@synthesize catid;
@synthesize catname;
@synthesize modelid;
@synthesize parentid;
//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.catid = [dataArray objectAtIndex:0];
    self.catname = [dataArray objectAtIndex:1];
    self.modelid = [dataArray objectAtIndex:2];
    self.parentid = [dataArray objectAtIndex:3];
}

@end
