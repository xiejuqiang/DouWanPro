//
//  NewsDetailViewController.m
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsDetailViewController.h"
//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "../../RecordDao.h"
#import "../../NewsListDBItem.h"
#import "../../NewsCategoryDBItem.h"
#import "NewsDetailDBItem.h"


@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

@synthesize nid;

@synthesize frameworkflag = _frameworkflag;
@synthesize default_url;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;

@synthesize netWorkFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight=result.height;
    
    //提示框
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //url
    urlStr = [[UrlStr alloc]init];
    //网络获取数据
    jsonParser = [[JsonParser alloc]init];
    
}

- (void)setNavigationAttributes
{
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAV_BACKGROUND_IMG] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.topItem.title = NAVBAR_TITLE_STR;
    //    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:5.0 forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorWithRed:255 green:255 blue:255 alpha:1],UITextAttributeTextColor,
                                    [UIFont systemFontOfSize:18],UITextAttributeFont,
                                    [UIColor grayColor],UITextAttributeTextShadowColor,
                                    [NSValue valueWithCGSize:CGSizeMake(1, 1)],UITextAttributeTextShadowOffset,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationItem.title =  @"新闻详细";
}

- (void)createView
{
    descripWebView = [[UIWebView alloc]init];
    
    switch (_frameworkflag)
    {
        case 1:
        {
            self.navigationController.navigationBar.tintColor = _navigationColor;
            self.navigationItem.title = _navigationTitle;
            self.view.frame = CGRectMake(0, 0, 320, windowHeight - framework_1_height_int);
        }
            break;
        case 2:
            self.view.frame = CGRectMake(0, framework_2_defaultX_int, 320, windowHeight - framework_2_height_int);
            break;
        case 3:
        case 4:
            [self setNavigationAttributes];
            break;
    }
    descripWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:descripWebView];
    descripWebView.delegate = self;
    descripWebView.scalesPageToFit = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
    [self getNewsDetailData];
    
}

- (void)getNewsDetailData
{
    [self showWithLoding];
    
    listArray = [recordDB resultSet:NEWSDETAIL_TABLENAME Order:nil LimitCount:0];
    [recordDB deleteAtIndex:NEWSDETAIL_TABLENAME CloValue:0];
    if([listArray count] == 0)
    {
        GetObj *getO = [[GetObj alloc]init];
        getO.nid = self.nid;
        NSString *newsDetailURL = [urlStr returnURL:22 Obj:getO];
        
        
        [jsonParser parse:newsDetailURL withDelegate:self onComplete:@selector(connectionNewsDetailSuccess:) onErrorComplete:@selector(connectionError)];
    }
    else
    {
        [self initWebView];
    }
}

- (void)initWebView
{
    NewsDetailDBItem *newsDetailDBItem = [listArray objectAtIndex:0];
    //webview的实现
//    NSString *htmlString=@"我的<b>iPhone</b>程序";
//    [descripWebView loadHTMLString:htmlString baseURL:nil];
	NSString *htmlBeforeString=[[NSMutableString alloc]initWithString:newsDetailDBItem.content];
	//拼接起来的html
	NSString *htmlString=[[NSMutableString alloc]initWithFormat:@"<!DOCTYPE HTML><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=100; initial-scale=1;maximum-scale=1;minimum-scale=1;user-scalable=no\" /><title></title>\n</head><body style=\"padding:0; margin:0\"><h1 style=\"color:#497FA1; padding:.6em 1em; font-size:20px;margin:0; line-height:1.2em; text-align:center\">%@</h1><p style=\"background:#BEBEBE;font-size:12px;margin:0; height:20px; line-height:20px; text-align:center\">%@&nbsp;&nbsp;&nbsp;来源:</p><div style=\"padding:.5em; line-height:1.4em; font-size:16px\">%@</div></body></html>",newsDetailDBItem.title,newsDetailDBItem.dateine,htmlBeforeString];
    NSBundle *bundle=[NSBundle mainBundle];
	[descripWebView setBackgroundColor:[UIColor whiteColor]];
	[descripWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[bundle bundlePath]]];
}
#pragma mark connection result
- (void)connectionNewsDetailSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    for (int i = 0 ; i<[returnDic count]; i++) {
       // NSArray *newsDetailArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"content"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"hits"]];
      
        NSArray *newsDetailArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"content"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"hits"], nil];
        [recordDB insertAtTable:NEWSDETAIL_TABLENAME Clos:newsDetailArray];
    }
    
    [self getNewsDetailData];
    [self hideHUD];
}

- (void)connectionError
{
    [self hideHUD];
    listArray = [recordDB resultSet:NEWSDETAIL_TABLENAME Order:nil LimitCount:0];
    if([listArray count] > 0)
        [self initWebView];
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"您未开启网络，请先设置网络"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
    }
}
#pragma mark alert

- (void)showWithLoding
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)showWithTime:(NSString *)lable
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = lable;
    [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    //	sleep(1);
}

- (void)hideHUD
{
    [HUD hide:YES];
}


#pragma mark webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)aweb
{
    [self hideHUD];
    [descripWebView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=285;"
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
//     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [descripWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
-(void )webViewDidStartLoad:(UIWebView  *)webView
{
    
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@", error);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
