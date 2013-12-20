//
//  UrlStr.h
//  MainFrame
//
//  Created by Tang silence on 13-7-2.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GetObj;
@interface UrlStr : NSObject
{
    
}
@property (nonatomic,retain) NSArray *infoArray;

- (NSString *)returnURL:(int)urlId Obj:(GetObj *)obj;
@end
