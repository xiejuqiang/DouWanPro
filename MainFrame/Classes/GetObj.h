//
//  GetObj.h
//  MainFrame
//
//  Created by Tang silence on 13-7-2.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetObj : NSObject
@property (nonatomic,retain) NSString *tid;
@property (nonatomic,retain) NSString *sid;
@property (nonatomic,retain) NSString *app_id;
@property (nonatomic,retain) NSString *modelid;
@property (nonatomic,retain) NSString *page;

@property (nonatomic,retain) NSString *catid;
@property (nonatomic,retain) NSString *nid;
@property (nonatomic,retain) NSString *pid;

@property (nonatomic,retain) NSString *source_type;//ios 新闻不分类，为了返回所有数据，以后还是要改掉
@property (nonatomic,retain) NSString *category; //为no则产品不分类

@end
