//
//  CoverViewController.m
//  FrameOfDemo
//
//  Created by apple on 13-7-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CoverViewController.h"
#import "Constant.h"
//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "../RecordDao.h"
#import "NewsScrollDBItem.h"


#import "MenuAttribute.h"
#import "../About.h"
#import "Function.h"
#import "NewsDetailViewController.h"
@interface CoverViewController ()

@end

@implementation CoverViewController
@synthesize proArray = _proArray;
@synthesize receiveData = _receiveData;
//@synthesize viewArray = _viewArray;
@synthesize systemSettingArray;
//@synthesize btnPicNameArr;
//@synthesize labelNameArr;
@synthesize menuAttributeArray;
@synthesize aboutMeUrl = _aboutMeUrl;
@synthesize frameworkflag = _frameworkflag;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;

#define ScrollH_iphone4 166
#define ScrollH_iphone5 236

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadScroll
{
    _proArray = [[NSMutableArray alloc] initWithArray:listArray];
    thumbArray = [[NSMutableArray alloc] init];
    NSMutableArray *thumb_id_array = [[NSMutableArray alloc] init];
    Function *function = [[Function alloc] init];
    NSArray *configArray = [function getDefaultURL];
    NSString *url_default = [configArray objectAtIndex:0];
    [self.view addSubview:hotNewView];
    if (iPhone5)
    {
        hotNewView.frame = CGRectMake(0, 0, 320, ScrollH_iphone5);
    }
    else
    {
        hotNewView.frame = CGRectMake(0, 0, 320, ScrollH_iphone4);
    }
    if (_proArray.count == 0) {
        NSLog(@"加载失败");
        [hotNewView createScrollView:1 thumbArr:nil thumbIDArr:nil];
       
    }
    else
    {
        for (int i= 0;i<[_proArray count];i++) {
            NewsScrollDBItem *item = [_proArray objectAtIndex:i];
            NSString *thumb_tempstr =item.thumb;
            NSString *thumb_id = item.nId;
            NSString *thumb_str = [[NSString alloc] initWithFormat:@"%@%@",url_default,thumb_tempstr];
            [thumbArray addObject:thumb_str];
            [thumb_id_array addObject:thumb_id];
        }
        [hotNewView createScrollView:[_proArray count] thumbArr:thumbArray thumbIDArr:thumb_id_array];
    }
   
//    scrollImgV.frame = 
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
    self.navigationItem.title = @"公司简介";
}

- (void)createView
{
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:MENU_BACKGROUND_IMG]];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    switch (self.frameworkflag) {
        case 1:
        {
            self.view.frame = CGRectMake(0, 0, 320, Screen_height - framework_1_height_int);
            
            self.navigationController.navigationBar.tintColor = _navigationColor;
            self.navigationItem.title = _navigationTitle;
        }
            break;
        case 2:
        {
            self.view.frame = CGRectMake(0, framework_2_defaultX_int, 320, Screen_height - framework_2_height_int);
        }
            break;
        case 3:
        case 4:
            [self setNavigationAttributes];
            break;
            break;
    }
    
    menuScroll = [[UIScrollView alloc] init];
    [imageView addSubview:menuScroll];
    menuScroll.delegate = self;
    //    menuScroll.pagingEnabled = YES;
    menuScroll.showsHorizontalScrollIndicator = NO;
    menuScroll.showsVerticalScrollIndicator = NO;
    
    if (iPhone5)
    {
        imageView.frame = CGRectMake(0, ScrollH_iphone5, 320, self.view.frame.size.height-ScrollH_iphone5);
        
    }
    else
    {
        imageView.frame = CGRectMake(0, ScrollH_iphone4, 320, self.view.frame.size.height-ScrollH_iphone4);
    }
    
    menuScroll.frame =CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
}

- (void)createButton
{   
    
    int row = 0;//按钮所在行
    int col = 0;//按钮所在列
    
    for (int i = 0; i<[systemSettingArray count] - 1; i++)
    {
        MenuAttribute *menuAttribute = [menuAttributeArray objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        
        NSString *btnImgName = menuAttribute.cloumnImgName;
        UIImage *img = [UIImage imageNamed:btnImgName];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        [menuScroll addSubview:btn];
        btn.tag = i+100;
        
        
        if (i%3 == 0)//满3换行
        {
            row++;
            col= 0;
        }
        else
        {
            col++;
        }
        if (i == 0) {
            row = 0;
            col = 0;
        }
        
        //        btn.center = [[pointArr objectAtIndex:i] CGPointValue];
        btn.center = CGPointMake(58.5+101.5*col, 40+100*row);
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width + 20, 50)];
        [menuScroll addSubview:label];
        label.text = menuAttribute.cloumnName;
        label.textColor = [UIColor colorWithRed:174 green:174 blue:174 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        //        label.center = [[labelArr objectAtIndex:i] CGPointValue];
        label.center = CGPointMake(58.5+101.5*col, 85+100*row);
        
    }
    int pageNum = 0;
    if (row>1)//超过2行，根据超过的行数加高scroll。117.5为间隔。
    {
        pageNum = row-1;
    }
    else
    {
        pageNum = 0;
    }
    
    menuScroll.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height+117.5*pageNum);
    
//    
//    NSString *btnName = [btnPicNameArr objectAtIndex:3];
//    UIImage *img = [UIImage imageNamed:btnName];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
//    [imageView addSubview:btn];
//    btn.tag = [systemSettingArray count]+100-1;
//    btn.center = [[pointArr objectAtIndex:[systemSettingArray count] -1] CGPointValue];
//    [btn setBackgroundImage:img forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width + 20, 50)];
//    [imageView addSubview:label];
//    label.text = @"扫描二维码";
//    label.textColor = [UIColor colorWithRed:174 green:174 blue:174 alpha:1];
//    label.font = [UIFont systemFontOfSize:14];
//    label.backgroundColor = [UIColor clearColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.center = [[labelArr objectAtIndex:[systemSettingArray count] -1] CGPointValue];
}

- (void)clickButton:(UIButton *)b
{
    int tag = b.tag-100;
    MenuAttribute *menuAttribute = [menuAttributeArray objectForKey:[NSString stringWithFormat:@"%d",tag + 1]];
    if([menuAttribute.cloumnVC isKindOfClass:[About class]])//调用相同的about模板，根据ID显示不同的页面
    {
        About *aboutVC = (About *)menuAttribute.cloumnVC;
        aboutVC.aboutMeUrl = menuAttribute.aboutURL;
        aboutVC.navigationTitle = menuAttribute.cloumnName;
        [self.navigationController pushViewController:aboutVC animated:YES];
        return;
    }
    [self.navigationController pushViewController:(UIViewController *)menuAttribute.cloumnVC animated:YES];
}

- (void)initData
{
    //数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //url
    urlStr = [[UrlStr alloc]init];
    //网络获取数据
    jsonParser = [[JsonParser alloc]init];
    
    hotNewView = [[HotNewsView alloc]init];
    hotNewView.hotNewsDelegate = self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self getNewsData];
    [self setNavigationAttributes];
    [self createView];
    [self createButton];
   
	// Do any additional setup after loading the view.
}

#pragma mark getData
- (void)getNewsData
{
    listArray = [recordDB resultSet:NEWSSCROLLLIST_TABLENAME Order:nil LimitCount:0];
    if([listArray count] == 0)
    {
        GetObj *getO = [[GetObj alloc]init];
        getO.app_id = appId;
        NSString *newsCategoryURL = [urlStr returnURL:29 Obj:getO];
        
        
        [jsonParser parse:newsCategoryURL withDelegate:self onComplete:@selector(connectionNewsScrollSuccess:) onErrorComplete:@selector(connectionError)];
    }
    else
    {
        
        NSLog(@"%@",listArray);
        [self loadScroll];
    }
}

- (void)connectionNewsScrollSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    for (int i = 0;i<[returnDic count];i++) {
        //NSArray *newsScrollClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"hits"]];

        NSArray *newsScrollClosArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"], nil];
        [recordDB insertAtTable:NEWSSCROLLLIST_TABLENAME Clos:newsScrollClosArray];
    }
    
    [self getNewsData];
}

- (void)connectionError
{
    listArray = [recordDB resultSet:NEWSSCROLLLIST_TABLENAME Order:nil LimitCount:0];
    if([listArray count] > 0)
        [self loadScroll];
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

- (void)delayScroll
{
    [hotNewView startTimer];
}

#pragma mark HotNewsDelegate
- (void)homeNewDetail:(int)hotNesID
{
    NewsDetailViewController *newsDVC = [[NewsDetailViewController alloc] init];
    NSString *hotID = [[NSString alloc] initWithFormat:@"%d",hotNesID];
    newsDVC.nid = hotID;
    newsDVC.navigationTitle = @"最新资讯";
    newsDVC.navigationColor = self.navigationColor;
    newsDVC.frameworkflag = self.frameworkflag;
    newsDVC.framework_1_height_int = self.framework_1_height_int;
    newsDVC.framework_2_defaultX_int = self.framework_2_defaultX_int;
    newsDVC.framework_2_height_int = self.framework_2_height_int;
    [self.navigationController pushViewController:newsDVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self performSelector:@selector(startTimer) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(delayScroll) withObject:nil afterDelay:2.5];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [timer invalidate];
//    timer = nil;
    [hotNewView destoryTimer];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
