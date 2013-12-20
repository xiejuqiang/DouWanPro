//
//  SystemConfigDBITem.m
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "SystemConfigDBItem.h"

@implementation SystemConfigDBItem
@synthesize cloKey;
@synthesize cloValue;
@synthesize sortNum;
@synthesize classN;
@synthesize note;

- (void)initData:(NSArray *)dataArray
{
    self.cloKey = [dataArray objectAtIndex:0];
    self.cloValue = [dataArray objectAtIndex:1];
    self.sortNum = [dataArray objectAtIndex:2];
    self.classN = [dataArray objectAtIndex:3];
    self.note = [dataArray objectAtIndex:4];
        
}
@end
