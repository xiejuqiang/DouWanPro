//
//  NewsListDBItem.m
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsListDBItem.h"

@implementation NewsListDBItem
@synthesize nid;
@synthesize catid;
@synthesize title;
@synthesize username;
@synthesize userid;
@synthesize thumb;
@synthesize description;

//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.nid = [dataArray objectAtIndex:0];
    self.catid = [dataArray objectAtIndex:1];
    self.title = [dataArray objectAtIndex:2];
    self.username = [dataArray objectAtIndex:3];
    self.userid = [dataArray objectAtIndex:4];
    self.thumb = [dataArray objectAtIndex:5];
    self.description = [dataArray objectAtIndex:6];
}
@end
