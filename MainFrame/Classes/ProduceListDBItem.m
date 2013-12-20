//
//  ProduceListDBItem.m
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "ProduceListDBItem.h"

@implementation ProduceListDBItem

@synthesize pid;
@synthesize catid;
@synthesize title;
@synthesize username;
@synthesize userid;
@synthesize thumb;
@synthesize description;
@synthesize price;
@synthesize xinghao;

//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.pid = [dataArray objectAtIndex:0];
    self.catid = [dataArray objectAtIndex:1];
    self.title = [dataArray objectAtIndex:2];
    self.username = [dataArray objectAtIndex:3];
    self.userid = [dataArray objectAtIndex:4];
    self.thumb = [dataArray objectAtIndex:5];
    self.description = [dataArray objectAtIndex:6];
    self.price = [dataArray objectAtIndex:7];
    self.xinghao = [dataArray objectAtIndex:8];
}

@end
