//
//  PostThread.m
//  MainFrame
//
//  Created by apple on 13-7-9.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "PostThread.h"
#import "ASIFormDataRequest.h"
#import "FeedBack.h"
#import "Constant.h"

@implementation PostThread
@synthesize postUrl;
@synthesize username;
@synthesize tel;
@synthesize content;
@synthesize postViewController;

- (void)main
{
    NSURL *url=[NSURL URLWithString:[postUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//建立URL
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSString *returnString;
    
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:tel forKey:@"tel"];
    [request setPostValue:content forKey:@"content"];
    [request setPostValue:appId forKey:@"app_id"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        returnString = [request responseString];
        ((FeedBack *)postViewController).returnString = returnString;
         [(FeedBack *)postViewController performSelectorOnMainThread:@selector(postResult) withObject:nil waitUntilDone:NO];
    }
    else
    {
         [(FeedBack *)postViewController performSelectorOnMainThread:@selector(postFail) withObject:nil waitUntilDone:NO];
    }
    
}

@end
