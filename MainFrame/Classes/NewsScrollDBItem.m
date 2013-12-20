//
//  NewsScrollDBItem.m
//  MainFrame
//
//  Created by Tang silence on 13-7-5.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsScrollDBItem.h"

@implementation NewsScrollDBItem

@synthesize nId;
@synthesize title;
@synthesize thumb;


//注意顺序要跟数据库字段创建顺序一致
- (void)initData:(NSArray *)dataArray
{
    self.nId = [dataArray objectAtIndex:0];
    self.title = [dataArray objectAtIndex:1];
    self.thumb = [dataArray objectAtIndex:2];

}

@end
