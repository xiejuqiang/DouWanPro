//
//  FeedBackListDBItem.h
//  MainFrame
//
//  Created by apple on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackListDBItem : NSObject
@property (nonatomic,retain) NSString *nId;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *tel;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *dateline;


- (void)initData:(NSArray *)dataArray;

@end
