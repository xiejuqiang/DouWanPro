//
//  Produce1ViewController.m
//  MainFrame
//
//  Created by Tang silence on 13-6-28.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "Produce1ViewController.h"
#import "Produce1Cell.h"
//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "RecordDao.h"
#import "ProduceCategoryDBItem.h"
#import "ProduceListDBItem.h"
//子界面
#import "ProduceDetailViewController.h"
#import "Product1CategoryViewController.h"

#import "Constant.h"

#define pageMax 20
@interface Produce1ViewController ()

@end

@implementation Produce1ViewController
@synthesize frameworkflag = _frameworkflag;
@synthesize default_url;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;
@synthesize netWorkFlag;
@synthesize step;
@synthesize categoryTempArray;
@synthesize rowTag;
@synthesize img_default_url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        step = 0;
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
    self.navigationItem.title = @"产品展示";
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
    if (step == 1) {
        [self getCategoryData];
    }
    else {
        [self getProduceListData];
    }

}

#pragma mark getCategoryData

- (void)getCategoryData
{
    [self showWithLoding];
//    step = 1;
    categoryArray = [recordDB resultSet:PRODUCE_CATEGORY_TABLENAME Order:nil LimitCount:0];
    if([categoryArray count] <=0)
    {
        GetObj *getO = [[GetObj alloc]init];
        getO.app_id = appId;
        NSString *produceCategoryURL = [urlStr returnURL:30 Obj:getO];
        
        
        [jsonParser parse:produceCategoryURL withDelegate:self onComplete:@selector(connectionCategorySuccess:) onErrorComplete:@selector(connectionError)];
    }
    else if([categoryArray count] == 1)
    {
        [self getProduceListData];
    }
    else
    {
//        Product1CategoryViewController *proCategoryVC = [[Product1CategoryViewController alloc] init];
//        proCategoryVC.categoryData = categoryArray;
//        [self.navigationController pushViewController:proCategoryVC animated:YES];
        
        
        NSString *selectSql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE parentId=%@",PRODUCE_CATEGORY_TABLENAME,@"28"];
        categoryChildArray = [recordDB resultSetWhere:PRODUCE_CATEGORY_TABLENAME Where:selectSql];
        
        listArray = categoryChildArray;
        [_mTableView reloadData];
        [HUD hide:YES];
    }
}

#pragma mark produce data
- (void)getProduceListData
{
    step = 2;
    produceListArray = [recordDB resultSet:PRODUCELIST_TABLENAME Order:nil LimitCount:pageNum*pageMax];
    [recordDB deleteAtIndex:PRODUCELIST_TABLENAME CloValue:0];
    if([produceListArray count] == 0)
    {
        ProduceCategoryDBItem *categoryDBItem = nil;
        if (categoryChildArray != nil) {
            categoryDBItem = [categoryChildArray objectAtIndex:1];
        }
        else
        {
            categoryDBItem = [self.categoryTempArray objectAtIndex:self.rowTag];
        }
        
        GetObj *getO = [[GetObj alloc]init];
        getO.catid = categoryDBItem.catid;
        getO.page = [NSString stringWithFormat:@"%d",pageNum];
        getO.app_id = appId;
//        getO.category = categoryDBItem.catid;
        NSString *newsListURL = [urlStr returnURL:31 Obj:getO];
        
        [jsonParser parse:newsListURL withDelegate:self onComplete:@selector(connectionNewsListSuccess:) onErrorComplete:@selector(connectionError)];
    }
    else
    {
        listArray = produceListArray;
        [_mTableView reloadData];
        [self hideHUD];
    }
}

#pragma mark connection result
- (void)connectionError
{
    if(step == 1)
    {
        categoryArray = [recordDB resultSet:PRODUCE_CATEGORY_TABLENAME Order:nil LimitCount:0];
        if([categoryArray count] > 0)
            [self getProduceListData];
        else
            [self showWithTime:@"连接错误,请检查网络！"];
    }
    else if(step == 2)
    {
        produceListArray = [recordDB resultSet:PRODUCELIST_TABLENAME Order:nil LimitCount:pageNum*pageMax];
        if([produceListArray count] == 0)
        {
            listArray = produceListArray;
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
        //NSArray *categoryClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"cname"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"modelid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"parentid"]];
    
        NSArray *categoryClosArray = [[NSArray alloc] initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"cname"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"modelid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"parentid"], nil];
        [recordDB insertAtTable:PRODUCE_CATEGORY_TABLENAME Clos:categoryClosArray];
    }
    [self getCategoryData];
}

- (void)connectionNewsListSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    for (int i = 0;i<[returnDic count];i++) {
//        NSLog(@"id %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"]);
//        NSLog(@"catid %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"]);
//        NSLog(@"title %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"]);
//        NSLog(@"user_name %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"]);
//        NSLog(@"user_id %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"]);
//        NSLog(@"thumb %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"]);
//        NSLog(@"description %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"]);
//        NSLog(@"xinghao %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"xinghao"]);
//        NSLog(@"price %@",[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"price"]);
        
        
       // NSArray *produceListClosArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"price"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"xinghao"]];
       
        NSArray *produceListClosArray =[[NSArray alloc ]initWithObjects:[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"catid"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"title"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_name"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"user_id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"thumb"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"description"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"price"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"xinghao"], nil];
        [recordDB insertAtTable:PRODUCELIST_TABLENAME Clos:produceListClosArray];
    }
    [self getProduceListData];
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
    
    if (step == 1)
    {
        ProduceCategoryDBItem *produceCategoryDBItem = [listArray objectAtIndex:row];
        NSString *tableIdentifier = @"CategoryTableIdentifier";
        UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = produceCategoryDBItem.catname;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
        return cell;
        
    }
    else
    {
    ProduceListDBItem *produceListDBItem = [listArray objectAtIndex:row];
    NSString *tableIdentifier = @"CustomTableIdentifier";
    Produce1Cell *cell=(Produce1Cell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if (cell == nil) {
        cell = [[Produce1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    [cell setTitleLabelText:produceListDBItem.title];
    //图片
    if([produceListDBItem.thumb isEqualToString:@""] == NO)
    {
        NSString *strImgURL = [[NSString alloc]initWithFormat:@"%@%@",self.img_default_url,produceListDBItem.thumb];
        [cell setImgStr:strImgURL];
    }
    
    [cell setDescripLabelText:produceListDBItem.description];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    return cell;
    }
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
    if (step == 1) {
        return 40.0;
    }
    else
    {
    return 80.0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    int row = indexPath.row;
    
    if (step == 1) {
        Produce1ViewController *produce1VC = [[Produce1ViewController alloc] init];
        produce1VC.step = 2;
        produce1VC.rowTag = row;
        produce1VC.categoryTempArray = categoryChildArray;
        produce1VC.img_default_url = default_url;
        produce1VC.frameworkflag = self.frameworkflag;
        produce1VC.framework_1_height_int = self.framework_1_height_int;
        produce1VC.framework_2_defaultX_int = self.framework_2_defaultX_int;
        produce1VC.framework_2_height_int = self.framework_2_height_int;
        produce1VC.navigationTitle = @"产品展示";
        produce1VC.navigationColor = self.navigationColor;
        [self.navigationController pushViewController:produce1VC animated:YES];
    }
    else
    {
    ProduceListDBItem *produceListDBItem = [listArray objectAtIndex:row];
    ProduceDetailViewController *produceDetailVC = [[ProduceDetailViewController alloc]init];
    produceDetailVC.pid = produceListDBItem.pid;
    produceDetailVC.frameworkflag = self.frameworkflag;
    produceDetailVC.framework_1_height_int = self.framework_1_height_int;
    produceDetailVC.framework_2_defaultX_int = self.framework_2_defaultX_int;
    produceDetailVC.framework_2_height_int = self.framework_2_height_int;
    
    produceDetailVC.navigationColor = self.navigationColor;
    produceDetailVC.navigationTitle = @"产品详细";
    switch (_frameworkflag) {
        case 1:
        case 3:
        case 4:
            [self.navigationController pushViewController:produceDetailVC animated:YES];
            break;
        case 2:
            
            break;
    }
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

