//
//  ProduceDetailDBItem.m
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "ProduceDetailDBItem.h"

@implementation ProduceDetailDBItem

@synthesize nid;
@synthesize title;
@synthesize content;
@synthesize catid;
@synthesize dateine;
@synthesize hits;
@synthesize price;
@synthesize xinghao;

//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.nid = [dataArray objectAtIndex:0];
    self.title = [dataArray objectAtIndex:1];
    self.content = [dataArray objectAtIndex:2];
    self.catid = [dataArray objectAtIndex:3];
    self.dateine = [dataArray objectAtIndex:4];
    self.hits = [dataArray objectAtIndex:5];
    self.price = [dataArray objectAtIndex:6];
    self.xinghao = [dataArray objectAtIndex:7];
}

@end
