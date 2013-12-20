//
//  About.m
//  About
//
//  Created by Tang silence on 13-6-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "About.h"
#import <QuartzCore/CALayer.h>


#define CENTER 160.0


//@interface About ()
//{
//    BOOL isAppear;
//    CGPoint startPoint;
//}
//@end

@implementation About

@synthesize aboutMeUrl = _aboutMeUrl;
@synthesize frameworkflag = _frameworkflag;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;

@synthesize netWorkFlag;
//@synthesize myDelegate = _myDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight=result.height;
    [self.view setUserInteractionEnabled:YES];
    
}
-(void)createView
{
    mWebView = [[UIWebView alloc]init];
    mWebView.delegate = self;
    mWebView.scalesPageToFit = YES;
    [mWebView setBackgroundColor:[UIColor whiteColor]];
    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
//    
//    NSBundle *bundle=[NSBundle mainBundle];
//    [mWebView loadHTMLString:str baseURL:[NSURL fileURLWithPath:[bundle bundlePath]]];
   
//    mWebView.delegate = self.myDelegate;
    if([_aboutMeUrl isEqualToString:@""]==YES)
    {
        NSLog(@"你妹，空的~");
        return;
    }
    
   
    switch (self.frameworkflag) {
        case 1:
        {
            self.view.frame = CGRectMake(0, 0, 320, windowHeight - framework_1_height_int);
            
            self.navigationController.navigationBar.tintColor = _navigationColor;
            self.navigationItem.title = _navigationTitle;
        }
            break;
        case 2:
        {
            self.view.frame = CGRectMake(0, framework_2_defaultX_int, 320, windowHeight - framework_2_height_int);
        }
            break;
        case 3:
        case 4:
            [self setNavigationAttributes];
            break;
            break;
    }
    mWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_aboutMeUrl]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [mWebView loadRequest:request];
    [self.view addSubview:mWebView];
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
    self.navigationItem.title = _navigationTitle;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
//    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createView];
    [self showWithLabel];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSString *meta = @"var table = document.getElementsByTagName(\"table\");for(var i=0;i<table.length;i++){table.item(i).width = \"100px\";}";
//    
//    [mWebView stringByEvaluatingJavaScriptFromString:meta];
}

- (void)webViewDidFinishLoad:(UIWebView *)aweb
{
    
    //是web不可滑
    [mWebView stringByEvaluatingJavaScriptFromString:
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
     "myimg.height = 140;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [mWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
//    [mWebView stringByEvaluatingJavaScriptFromString:
//     @"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//     "var myimg,oldwidth;"
//     "var maxwidth=285;"
//     "for(i=0;i <document.getElementsByTagName(\"table\").length;i++){"
//     "myimg = document.getElementsByTagName(\"table\").item(i);"
//     "if(myimg.width > maxwidth){"
//     "oldwidth = myimg.width;"
//     "myimg.width = maxwidth;"
//     "myimg.height = myimg.height * (maxwidth/oldwidth);"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [mWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//    CGSize goodSize = [mWebView sizeThatFits:CGSizeMake(285,400)];
    
//   NSString *output = [mWebView stringByEvaluatingJavaScriptFromString:@"document.getElementByClass(\"ke-zeroborder\").offsetWidth;"];
    
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByTagName(\"table\")[0].style.width=100"];
//    [mWebView stringByEvaluatingJavaScriptFromString:meta];
//
//    if(event.srcElement.getAttribute("name") == "set"){
//        document.body.style.cursor = "e-resize";
//        pre_currentTd_width = element_td.previousSibling.offsetWidth; // 放上时返回单元格前一个单元格的相对宽度
//        currentTd_width = element_td.offsetWidth; // 放上时返回单元格的相对宽度
//    }
    
   
    
    
    

    [HUD hide:YES];
}
- (void)showWithLabel
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"加载中...";
	
	[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    //	sleep(1);
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
