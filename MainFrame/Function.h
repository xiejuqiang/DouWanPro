//
//  Function.h
//  MainFrame
//
//  Created by Tang silence on 13-6-28.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImgWidthHeight.h"

@interface Function : NSObject
-(NSMutableDictionary *)autoZoomImg:(NSString *)imgUrl NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight realWidth:(int)imageWidth realHeight:(int)imageHeight;
-(ImgWidthHeight *)autoZoomImgRange:(NSString *)imgUrl NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight realWidth:(int)imageWidth realHeight:(int)imageHeight;
-(ImgWidthHeight *)autoZoomImgRange1:(int)imageWidth realHeight:(int)imageHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight;
-(NSMutableDictionary *)autoZoomImg:(int)imgWidth realHeight:(int)imgHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight;
-(ImgWidthHeight *)autoZoomImgRange:(int)imageWidth realHeight:(int)imageHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight;
- (NSMutableArray *)getDefaultURL;

@end
