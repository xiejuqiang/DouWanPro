//
//  FeedBackListDBItem.m
//  MainFrame
//
//  Created by apple on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "FeedBackListDBItem.h"

@implementation FeedBackListDBItem

@synthesize nId;
@synthesize username;
@synthesize tel;
@synthesize content;
@synthesize dateline;


//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.nId = [dataArray objectAtIndex:0];
    self.username = [dataArray objectAtIndex:1];
    self.tel = [dataArray objectAtIndex:2];
    self.content = [dataArray objectAtIndex:3];
    self.dateline = [dataArray objectAtIndex:4];

}

@end
