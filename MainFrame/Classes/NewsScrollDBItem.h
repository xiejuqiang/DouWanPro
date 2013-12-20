//
//  NewsScrollDBItem.h
//  MainFrame
//
//  Created by Tang silence on 13-7-5.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsScrollDBItem : NSObject

@property (nonatomic,retain) NSString *nId;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *thumb;


- (void)initData:(NSArray *)dataArray;

@end
