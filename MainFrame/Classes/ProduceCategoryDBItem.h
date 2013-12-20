//
//  ProduceCategoryDBItem.h
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProduceCategoryDBItem : NSObject

@property (nonatomic, retain) NSString *catid;
@property (nonatomic, retain) NSString *catname;
@property (nonatomic, retain) NSString *modelid;
@property (nonatomic, retain) NSString *parentid;

- (void)initData:(NSArray *)dataArray;

@end
