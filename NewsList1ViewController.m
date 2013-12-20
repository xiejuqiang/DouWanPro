//
//  NewsListViewController1.m
//  MainFra
//
//  Created by Tang silence on 13-6-24.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsList1ViewController.h"
#import "NewsList1Cell.h"
#import "NewsListDBItem.h"
//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "RecordDao.h"
#import "NewsListDBItem.h"
#import "NewsCategoryDBItem.h"
#import "NewsDetailViewController.h"

#import "Constant.h"


#define pageMax 20

@interface NewsList1ViewController ()

@end

@implementation NewsList1ViewController
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
        step = 0;
    }
    return self;
}
#pragma mark initdata
-(void)initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight = result.height;
    //提示框
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //url
    urlStr = [[UrlStr alloc]init];
    //页码
    pageNum = 1;
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
    self.navigationItem.title = @"新闻公告";
}

#pragma mark createview
-(void)createView
{    
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    switch (_frameworkflag) {
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
    _mTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self setExtraCellLineHidden:_mTableView];
    [self.view addSubview:_mTableView];
}
#pragma mark load
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
    [self getCategoryData];
}

#pragma mark getCategoryData

- (void)getCategoryData
{
    [self showWithLoding];
    
    categoryArray = [recordDB resultSet:NEWS_CATEGORY_TABLENAME Order:nil LimitCount:0];
    if([categoryArray count] <=0)
    {
        GetObj *getO = [[GetObj alloc]init];
        getO.app_id = appId;
        NSString *newsCategoryURL = [urlStr returnURL:20 Obj:getO];
        step = 1;
        
        [jsonParser parse:newsCategoryURL withDelegate:self onComplete:@selector(connectionCategorySuccess:) onErrorComplete:@selector(connectionError)];
    }
    else if([categoryArray count] == 1)
    {
        [self getNewsListData];
    }
    else
    {
        [self getNewsListData];
    }
}

#pragma mark newsList data
- (void)getNewsListData
{
    newsListArray = [recordDB resultSet:NEWSLIST_TABLENAME Order:nil LimitCount:pageNum*pageMax];
    if([newsListArray count] == 0)
    {
        step = 1;
        NewsCategoryDBItem *categoryDBItem = [categoryArray objectAtIndex:1];
        GetObj *getO = [[GetObj alloc]init];
        getO.catid = categoryDBItem.catid;
        getO.page = [NSString stringWithFormat:@"%d",pageNum];
        NSString *newsListURL = [urlStr returnURL:21 Obj:getO];
        
        [jsonParser parse:newsListURL withDelegate:self onComplete:@selector(connectionNewsListSuccess:) onErrorComplete:@selector(connectionError)];
    }
    else
    {
        listArray = newsListArray;
        [_mTableView reloadData];
        [self hideHUD];
    }
}

#pragma mark connection result
- (void)connectionError
{
    if(step == 1)
    {
        categoryArray = [recordDB resultSet:NEWS_CATEGORY_TABLENAME Order:nil LimitCount:0];
        if([categoryArray count] > 0)
            [self getNewsListData];
        else
            [self showWithTime:@"连接错误,请检查网络！"];
    }
    else if(step == 2)
    {
        newsListArray = [recordDB resultSet:NEWSLIST_TABLENAME Order:nil LimitCount:pageNum*pageMax];
        if([newsListArray count] == 0)
        {
            listArray = newsListArray;
            [_mTableView reloadData];
            [self hideHUD];
        }
        else
            [self showWithTime:@"连接错误,请检查网络！"];
    }
}

- (void)connectionCategorySuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    for (int i = 0;i<[returnDic count];i++) {
       // NSArray *categoryClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"cname"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"modelid"]];

        NSArray *categoryClosArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"cname"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"modelid"], nil];
        [recordDB insertAtTable:NEWS_CATEGORY_TABLENAME Clos:categoryClosArray];
    }
    
    [self getCategoryData];
}

- (void)connectionNewsListSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    for (int i = 0;i<[returnDic count];i++) {
       // NSArray *newsListClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"]];
        NSArray *newsListClosArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"], nil];
        [recordDB insertAtTable:NEWSLIST_TABLENAME Clos:newsListClosArray];
    }
    [self getNewsListData];
}

#pragma mark showHud

- (void)showWithTime:(NSString *)lable
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = lable;
    [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)showWithLoding
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    //	sleep(1);
}

- (void)hideHUD
{
    [HUD hide:YES];
}

#pragma mark tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    
    NewsListDBItem *newsListDBItem = [listArray objectAtIndex:row];
    NSString *tableIdentifier = @"CustomTableIdentifier";
    NewsList1Cell *cell=(NewsList1Cell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if (cell == nil) {
        cell = [[NewsList1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    [cell setTitleLabelText:newsListDBItem.title];
    //图片
    if([newsListDBItem.thumb isEqualToString:@""] == NO)
    {
        NSString *strImgURL = [[NSString alloc]initWithFormat:@"%@%@",default_url,newsListDBItem.thumb];
        [cell setImgStr:strImgURL];
    }
    
    [cell setDescripLabelText:newsListDBItem.description];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    return cell;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [listArray count];
    if(count >0)
    {
        _mTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    }
    else {
        _mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return count;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    int row = indexPath.row;
    NewsListDBItem *newsListDBItem = [listArray objectAtIndex:row];
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]init];
    newsDetailVC.nid = newsListDBItem.nid;
    newsDetailVC.frameworkflag = self.frameworkflag;
    newsDetailVC.framework_1_height_int = self.framework_1_height_int;
    newsDetailVC.framework_2_defaultX_int = self.framework_2_defaultX_int;
    newsDetailVC.framework_2_height_int = self.framework_2_height_int;
    
    newsDetailVC.navigationColor = self.navigationColor;
    newsDetailVC.navigationTitle = @"新闻详细";
    switch (_frameworkflag) {
        case 1:
        case 3:
        case 4:
            [self.navigationController pushViewController:newsDetailVC animated:YES];
            break;
        case 2:
            
            break;
    }
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
