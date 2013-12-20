//
//  Function.m
//  MainFrame
//
//  Created by Tang silence on 13-6-28.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "Function.h"

@implementation Function


-(NSMutableDictionary *)autoZoomImg:(NSString *)imgUrl NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight realWidth:(int)imageWidth realHeight:(int)imageHeight
{
	
    /*
	 图片的等比例缩放
	 */
    float imgWidth,imgHeight;
    if(imageWidth ==0 || imageHeight == 0)
    {
        UIImage *largeImage=[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        imgWidth = largeImage.size.width;
        imgHeight = largeImage.size.height;
    }
    else
    {
        imgWidth = imageWidth;
        imgHeight = imageHeight;
    }
    
    float wScale=nowWindowsWidth/imgWidth;  //宽比例
	float hScale=nowWindowsHeight/imgHeight; //高比例
    float x,y,w,h;
    if(wScale*imgHeight<nowWindowsHeight)
    {
        x = 0;
        y = (nowWindowsHeight-imgHeight*wScale)/2;
        w = nowWindowsWidth;
        h = imgHeight*wScale;
    }
    else
    {
        x = (nowWindowsWidth - hScale*imgWidth)/2;
        y = 0;
        w = hScale * imgWidth;
        h = nowWindowsHeight;
    }
    NSMutableDictionary *array = [[NSMutableDictionary alloc]init];
    [array setValue:[NSNumber numberWithFloat:x] forKey:@"x"];
    [array setValue:[NSNumber numberWithFloat:y] forKey:@"y"];
    [array setValue:[NSNumber numberWithFloat:w] forKey:@"w"];
    [array setValue:[NSNumber numberWithFloat:h] forKey:@"h"];
    
	return array;
}
-(ImgWidthHeight *)autoZoomImgRange:(NSString *)imgUrl NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight realWidth:(int)imageWidth realHeight:(int)imageHeight
{
    /*
	 图片的等比例缩放
	 */
	//NSLog(@"======%@",imgUrl);
    float imgWidth,imgHeight;
    if(imageWidth ==0 || imageHeight == 0)
    {
        UIImage *largeImage=[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        imgWidth = largeImage.size.width;
        imgHeight = largeImage.size.height;
    }
    else
    {
        imgWidth = imageWidth;
        imgHeight = imageHeight;
    }
    float wScale=nowWindowsWidth/imgWidth;  //宽比例
	float hScale=nowWindowsHeight/imgHeight; //高比例
    float w,h;
    if(wScale*imgHeight<nowWindowsHeight)
    {
        w = nowWindowsWidth;
        h = imgHeight*wScale;
    }
    else
    {
        w = hScale * imgWidth;
        h = nowWindowsHeight;
    }
    ImgWidthHeight *imageInfo = [[ImgWidthHeight alloc]init];
    imageInfo.width = w;
    imageInfo.height = h;
	return imageInfo;
}
-(NSMutableDictionary *)autoZoomImg:(int)imgWidth realHeight:(int)imgHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight
{
    if(nowWindowsWidth == 0 || nowWindowsHeight == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        nowWindowsWidth = [[defaults objectForKey:@"com.medp.edp.window.width"]floatValue];
        nowWindowsHeight = [[defaults objectForKey:@"com.medp.edp.window.height"]floatValue];
    }
    float wScale=nowWindowsWidth/imgWidth;  //宽比例
	float hScale=nowWindowsHeight/imgHeight; //高比例
    float x,y,w,h;
    if(wScale*imgHeight<nowWindowsHeight)
    {
        x = 0;
        y = (nowWindowsHeight-imgHeight*wScale)/2;
        w = nowWindowsWidth;
        h = imgHeight*wScale;
    }
    else
    {
        x = (nowWindowsWidth - hScale*imgWidth)/2;
        y = 0;
        w = hScale * imgWidth;
        h = nowWindowsHeight;
    }
    NSMutableDictionary *array = [[NSMutableDictionary alloc]init];
    [array setValue:[NSNumber numberWithFloat:x] forKey:@"x"];
    [array setValue:[NSNumber numberWithFloat:y] forKey:@"y"];
    [array setValue:[NSNumber numberWithFloat:w] forKey:@"w"];
    [array setValue:[NSNumber numberWithFloat:h] forKey:@"h"];
    
	return array;
}
-(ImgWidthHeight *)autoZoomImgRange1:(int)imageWidth realHeight:(int)imageHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight
{
    if(nowWindowsWidth == 0 || nowWindowsHeight == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        nowWindowsWidth = [[defaults objectForKey:@"com.medp.edp.window.width"]floatValue];
        nowWindowsHeight = [[defaults objectForKey:@"com.medp.edp.window.height"]floatValue];
    }
    
    float wScale=imageWidth/nowWindowsWidth;  //宽比例
	float hScale=imageHeight/nowWindowsHeight; //高比例
    float w,h;
    if(wScale*imageHeight<nowWindowsHeight)
    {
        w = nowWindowsWidth;
        h = imageHeight*wScale;
    }
    else
    {
        w = hScale * imageWidth;
        h = nowWindowsHeight;
    }
    ImgWidthHeight *imageInfo = [[ImgWidthHeight alloc]init];
    imageInfo.width = w;
    imageInfo.height = h;
	return imageInfo;
}
-(ImgWidthHeight *)autoZoomImgRange:(int)imageWidth realHeight:(int)imageHeight NowWindowsWidth:(float)nowWindowsWidth NowWindowsHeight:(float)nowWindowsHeight
{
    if(nowWindowsWidth == 0 || nowWindowsHeight == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        nowWindowsWidth = [[defaults objectForKey:@"com.medp.edp.window.width"]floatValue];
        nowWindowsHeight = [[defaults objectForKey:@"com.medp.edp.window.height"]floatValue];
    }
    
    float wScale=nowWindowsWidth/imageWidth;  //宽比例
	float hScale=nowWindowsHeight/imageHeight; //高比例
    float w,h;
    if(wScale*imageHeight<nowWindowsHeight)
    {
        w = nowWindowsWidth;
        h = imageHeight*wScale;
    }
    else
    {
        w = hScale * imageWidth;
        h = nowWindowsHeight;
    }
    ImgWidthHeight *imageInfo = [[ImgWidthHeight alloc]init];
    imageInfo.width = w;
    imageInfo.height = h;
	return imageInfo;
}

- (NSMutableArray *)getDefaultURL
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    NSString *jsonName = @"config.json";
    NSArray *Array = [jsonName componentsSeparatedByString:@"."];
    NSString *filename = [Array objectAtIndex:0];
    NSString *sufix = [Array objectAtIndex:1];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    id JsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//read json data
    
    NSDictionary *dic =  [JsonObject objectAtIndex:0];
    NSString *url = [dic objectForKey:@"url"];
    NSString *app_id = [dic objectForKey:@"id"];
    [resultArray addObject:url];
    [resultArray addObject:app_id];
    return resultArray;
}



@end
