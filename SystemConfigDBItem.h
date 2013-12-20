//
//  SystemConfigDBITem.h
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConfigDBItem : NSObject


@property (nonatomic,retain)NSString *cloKey;
@property (nonatomic,retain)NSString *cloValue;
@property (nonatomic,retain)NSString *sortNum;
@property (nonatomic,retain)NSString *classN;
@property (nonatomic,retain)NSString *note;
- (void)initData:(NSArray *)dataArray;
@end
