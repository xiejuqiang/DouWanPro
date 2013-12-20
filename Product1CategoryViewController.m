//
//  Product1CategoryViewController.m
//  MainFrameSY
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "Product1CategoryViewController.h"
#import "ProduceCategoryDBItem.h"

@interface Product1CategoryViewController ()

@end

@implementation Product1CategoryViewController
@synthesize categoryData;

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
    [self setNavigationAttributes];
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
    self.navigationItem.title = @"产品类别";
    
    //左边的消失按钮
	UIBarButtonItem *misButton=[[UIBarButtonItem alloc] initWithTitle:@"返回"
																style:UIBarButtonItemStyleBordered
															   target:self
															   action:@selector(misThisView)];
	self.navigationItem.leftBarButtonItem = misButton;
    
}

-(void)misThisView
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
	// Do any additional setup after loading the view.
}

- (void)createView
{
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self setExtraCellLineHidden:_mTableView];
    [self.view addSubview:_mTableView];
}

#pragma mark tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    
    ProduceCategoryDBItem *produceCategoryDBItem = [categoryData objectAtIndex:row];
    NSString *tableIdentifier = @"CategoryTableIdentifier";
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    [cell setTitleLabelText:produceListDBItem.title];
    //图片
//    if([produceListDBItem.thumb isEqualToString:@""] == NO)
//    {
//        NSString *strImgURL = [[NSString alloc]initWithFormat:@"%@%@",default_url,produceListDBItem.thumb];
//        [cell setImgStr:strImgURL];
//    }
    
//    [cell setDescripLabelText:produceListDBItem.description];
   
    cell.textLabel.text = produceCategoryDBItem.catname;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    return cell;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.categoryData count];
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
    return 40.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    int row = indexPath.row;
//    ProduceListDBItem *produceListDBItem = [listArray objectAtIndex:row];
//    ProduceDetailViewController *produceDetailVC = [[ProduceDetailViewController alloc]init];
//    produceDetailVC.pid = produceListDBItem.pid;
//    produceDetailVC.frameworkflag = self.frameworkflag;
//    produceDetailVC.framework_1_height_int = self.framework_1_height_int;
//    produceDetailVC.framework_2_defaultX_int = self.framework_2_defaultX_int;
//    produceDetailVC.framework_2_height_int = self.framework_2_height_int;
//    
//    produceDetailVC.navigationColor = self.navigationColor;
//    produceDetailVC.navigationTitle = @"产品详细";
//    switch (_frameworkflag) {
//        case 1:
//        case 3:
//        case 4:
//            [self.navigationController pushViewController:produceDetailVC animated:YES];
//            break;
//        case 2:
//            
//            break;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

@end
