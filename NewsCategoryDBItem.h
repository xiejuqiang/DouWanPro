//
//  CategoryDBItem.h
//  MainFrame
//
//  Created by Tang silence on 13-7-3.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCategoryDBItem : NSObject

@property (nonatomic, retain) NSString *catid;
@property (nonatomic, retain) NSString *catname;
@property (nonatomic, retain) NSString *modelid;

- (void)initData:(NSArray *)dataArray;

@end
