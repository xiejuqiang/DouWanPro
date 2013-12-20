//
//  PostThread.h
//  MainFrame
//
//  Created by apple on 13-7-9.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostThread : NSOperation

@property (nonatomic,retain)NSString *postUrl;
@property (nonatomic,retain)NSString *username;
@property (nonatomic,retain)NSString *tel;
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)id postViewController;


@end
