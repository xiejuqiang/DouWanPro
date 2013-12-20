//
//  StyleViewController.m
//  CoverStyle
//
//  Created by apple on 13-7-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "StyleViewController.h"
#import "MenuCell.h"
#import "Constant.h"
#import "../SystemConfigDBItem.h"
//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "../RecordDao.h"
#import "NewsScrollDBItem.h"
#import "HotNewsView.h"

#import "MenuAttribute.h"

@interface StyleViewController ()

@end

@implementation StyleViewController
//@synthesize viewArray = _viewArray;
@synthesize systemSettingArray;
//@synthesize menuPicNameArr;
//@synthesize menuNameArr;

@synthesize menuAttributeArray;
@synthesize proArray = _proArray;

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
//数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //url
    urlStr = [[UrlStr alloc]init];
    //网络获取数据
    jsonParser = [[JsonParser alloc]init];

}


- (void)loadScroll
{
    _proArray = [[NSMutableArray alloc] initWithArray:listArray];
    thumbArray = [[NSMutableArray alloc] init];
    hotNewsView = [[HotNewsView alloc] init];
    [self.view  addSubview:hotNewsView];
    if (iPhone5)
    {
       hotNewsView.frame = CGRectMake(0, 0, 320, 186+35);
    }
    else
    {
       hotNewsView.frame = CGRectMake(0, 0, 320, 186-15);
    }
    if (_proArray.count == 0) {
        NSLog(@"加载失败");
        [hotNewsView createScrollView:1 thumbArr:nil];
        
    }
    else
    {
        for (int i= 0;i<[_proArray count];i++) {
            NewsScrollDBItem *item = [_proArray objectAtIndex:i];
            NSString *thumb_tempstr =item.thumb;
            NSString *thumb_str = [DEFAULT_ABOUT_URL stringByAppendingString:thumb_tempstr];
            [thumbArray addObject:thumb_str];
        }
        [hotNewsView createScrollView:[_proArray count] thumbArr:thumbArray];
    }
    
    //    scrollImgV.frame =
}


- (void)createTableView
{
    menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 186+35, 320, 5*57)];
    menuTableView.delegate = self;
    menuTableView.scrollEnabled = NO;
    menuTableView.dataSource = self;
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:menuTableView];
    if (iPhone5)
    {
        menuTableView.frame = CGRectMake(0, 186+35, 320, 5*57);
        
    }
    else
    {
       
        menuTableView.frame = CGRectMake(0, 186-15, 320, 5*49);
    }

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
      //  NSArray *newsScrollClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"hits"]];

        NSArray *newsScrollClosArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"hits"], nil];
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

#pragma mark -
#pragma mark tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [systemSettingArray count] - 1 + codeC;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone5)
    {
         return 57.0;
    }
    else
    {
        return 49.0;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    MenuAttribute *menuAttribute = [menuAttributeArray objectForKey:[NSString stringWithFormat:@"%d",row+1]];
    
    
    NSString *picName = menuAttribute.cloumnImgName;
    NSString *menuName = menuAttribute.cloumnName;
    static NSString *CellIdentifier = @"MenuCellID";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier menuPicName:picName menuName:menuName];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    int row = indexPath.row;
    MenuAttribute *menuAttribute = [menuAttributeArray objectForKey:[NSString stringWithFormat:@"%d",row + 1]];
    
    [self.navigationController pushViewController:(UIViewController *)menuAttribute.cloumnVC animated:YES];
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
    self.navigationController.navigationBar.topItem.title = NAVBAR_TITLE_STR;
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationAttributes];
    [self initData];
    [self getNewsData];
    [self createTableView];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [hotNewsView startTimer];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [hotNewsView destoryTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
