//
//  ProduceListDBItem.h
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProduceListDBItem : NSObject

@property (nonatomic, retain) NSString *pid; //产品Id
@property (nonatomic, retain) NSString *catid; //分类id
@property (nonatomic, retain) NSString *title; //产品名臣
@property (nonatomic, retain) NSString *username; //用户名
@property (nonatomic, retain) NSString *userid; //用户id
@property (nonatomic, retain) NSString *thumb; //缩略图
@property (nonatomic, retain) NSString *description; //简介
@property (nonatomic, retain) NSString *price; //价格
@property (nonatomic, retain) NSString *xinghao; //型号

- (void)initData:(NSArray *)dataArray;

@end
