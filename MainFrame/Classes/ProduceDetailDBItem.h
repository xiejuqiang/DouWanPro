//
//  ProduceDetailDBItem.h
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProduceDetailDBItem : NSObject

@property (nonatomic,retain) NSString *nid;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *catid;
@property (nonatomic,retain) NSString *dateine;
@property (nonatomic,retain) NSString *hits;
@property (nonatomic,retain) NSString *price;
@property (nonatomic,retain) NSString *xinghao;

- (void)initData:(NSArray *)dataArray;

@end
