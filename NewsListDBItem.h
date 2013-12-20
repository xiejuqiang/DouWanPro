//
//  NewsListDBItem.h
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListDBItem : NSObject
@property (nonatomic, retain) NSString *nid;
@property (nonatomic, retain) NSString *catid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *userid;
@property (nonatomic, retain) NSString *thumb;
@property (nonatomic, retain) NSString *description;

- (void)initData:(NSArray *)dataArray;
@end
