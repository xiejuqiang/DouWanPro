//
//  JsonParser.m
//  MainFrame
//
//  Created by Tang silence on 13-7-2.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser
@synthesize itemData = _itemData;

- (id) init{
	self = [super init];
	if (self) {
		success = NO;
		loading = NO;
		parsed = NO;
	}
	return self;
}
-(BOOL)isHaveFlag:(NSString *)returnString
{
    NSRange tRange = [returnString rangeOfString:@"\"flag\":" options:NSCaseInsensitiveSearch];
    if(tRange.location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

//得到数组的信息
- (id)getItems
{
    
    return returnDic;
}

- (void)parse:(NSString *)url withDelegate:(id)sender onComplete:(SEL)callback onErrorComplete:(SEL)errorCallBack
{
    parentDelegate = sender;
    onCompleteCallback = callback;
    onErrorCompleteCallback = errorCallBack;
    requestUrl = url;
    loading = YES;
    
//    requestUrl = @"http://news.medp.cn/portal.php?fid=109&t_fid=109&mod=list&catid=179&page=1&source=ios&sid=(null)";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[[NSURL alloc] initWithString:requestUrl]];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = 10;
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    id result = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"result %@",result);
    
    _itemData = [[NSMutableData data] retain];
}

#pragma mark NSURLConnection delegate methods
//当xml被接收的时候，进行连接
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        //  NSLog(@"RSSParser: Response is an NSHTTPURLResponse: Response=%d",[httpResponse statusCode]);
        
		if ([httpResponse statusCode] >= 400 && [httpResponse statusCode] <= 599) {
            success = NO;
        } else if([httpResponse statusCode] >= 100 && [httpResponse statusCode] <= 299) {
            success = YES;
        } else {
            // NSLog(@"RSSParser: Status code is unknown.");
        }
		
    }
	
}

//添加数据里面的信息内容
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_itemData appendData:data];
}
//连接之后进行的操作
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    returnDic = [NSJSONSerialization JSONObjectWithData:_itemData
                                                         options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",returnDic);
    if([returnDic count] >0)
    {
        if ([parentDelegate respondsToSelector:onCompleteCallback]) {
            [parentDelegate performSelector:onCompleteCallback withObject:self];
        }
    }
}

//连接报错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    success = NO;
    loading = NO;
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    [parentDelegate performSelector:onErrorCompleteCallback withObject:self];
//#pragma clang diagnostic pop
    if ([parentDelegate respondsToSelector:onErrorCompleteCallback]) {
        [parentDelegate performSelector:onErrorCompleteCallback withObject:self];
    }
    NSLog(@"连接超时");
}

//连接身份认证
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    success = NO;
}

@end
