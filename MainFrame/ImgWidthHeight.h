//
//  ImgWidthHeight.h
//  EDP
//
//  Created by duk on 12-6-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgWidthHeight : NSObject {
    float width;
    float height;
    float x;
    float y;
}
@property float width;
@property float height;
@property float x;
@property float y;
@property (nonatomic,retain) NSString *imgUrl;
@end
