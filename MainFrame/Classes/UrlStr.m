//
//  UrlStr.m
//  MainFrame
//
//  Created by Tang silence on 13-7-2.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "UrlStr.h"
#import "GetObj.h"
#import "Constant.h"
#import "VersionThread.h"
#import "Function.h"


@implementation UrlStr
@synthesize infoArray = _infoArray;

- (NSString *)returnURL:(int)urlId Obj:(GetObj *)obj
{
    NSString *returnStr = nil;
    
    Function *function = [[Function alloc] init];
    NSArray *resultData = [function getDefaultURL];
    NSString *defaultURL = [resultData objectAtIndex:0];
    NSString *app_id = [resultData objectAtIndex:1];
    
    switch (urlId) {
        case 1:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=index&a=index&app_id=%@",defaultURL,app_id];
            NSLog(@"获取Layout:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 2:
            break;
        case 20:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=news&a=category&app_id=%@",defaultURL,app_id];
            NSLog(@"获取新闻栏目:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 21:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=news&a=index&catid=%@&page=%@",defaultURL,obj.catid,obj.page];
            NSLog(@"获取某个栏目下的新闻列表:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 22:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=news&a=detail&id=%@",defaultURL,obj.nid];
            NSLog(@"获取新闻的内容详细页:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 29:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=Index&a=homeshow&app_id=%@",defaultURL,app_id];
            NSLog(@"获取新闻滚动条:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 30:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=product&a=category&app_id=%@",defaultURL,app_id];
            NSLog(@"获取产品栏目:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 31:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=product&a=index&catid=%@&page=%@&app_id=%@",defaultURL,obj.catid,obj.page,app_id];
            NSLog(@"获取某个产品栏目下的产品列表:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 32:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=product&a=detail&id=%@",defaultURL,obj.pid];
            NSLog(@"某个产品的详细页:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 40:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=picture&a=index&catid=%@&page=%@",defaultURL,obj.catid,obj.page];
            NSLog(@"获取某个图片栏目下的图集列表:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 41:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=picture&a=detail&id=%@",defaultURL,obj.pid];
            NSLog(@"获取某个图片集:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 50:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=index&a=guestbook",defaultURL];
            NSLog(@"在线留言提交:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 51:
            returnStr = [[NSString alloc]initWithFormat:@"%@app/index.php?m=index&a=guestbooklist&app_id=%@&page=%@",defaultURL,app_id,obj.page];
            NSLog(@"反馈列表:%@",returnStr);
            return [returnStr autorelease];
            break;
        case 52:
            returnStr = [[NSString alloc]initWithFormat:@"%@Uploads/aboutus/%@.html",defaultURL,obj.catid];
            NSLog(@"反馈列表:%@",returnStr);
            return [returnStr autorelease];
            break;
    }
    return nil;
}

-(void)versionGet
{
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init]autorelease];
    VersionThread *postThread = [[VersionThread alloc]init];
    postThread.functionF = self;
    [queue addOperation:postThread];
    [postThread release];
}
-(void)versionCompare
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDic);
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"appVersion %@",appVersion);
    if ([_infoArray count]) {
        NSDictionary *releaseInfo = [_infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        NSLog(@"lastVersion %@",lastVersion);
        if (![lastVersion isEqualToString:appVersion]) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil] autorelease];
            [alert show];
        }
        else
        {
//            if(_versionGetFlag == 1)
//                [self showHud:@"当前已是最新版本" IsHide:YES];
        }
    }
}

@end
