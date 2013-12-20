//
//  MoreViewController.m
//  MainFrameSY
//
//  Created by Tang silence on 13-7-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "MoreViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "../About.h"
#import "CodeViewController.h"
#import "../FeedBack.h"
#import "Constant.h"
#define groupNum1 3
#define groupNum2 2

@interface MoreViewController ()

@end

@implementation MoreViewController

@synthesize frameworkflag = _frameworkflag;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;
@synthesize default_url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initData];
    [self createView];
}
- (void) initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight = result.height;
//    nameArray=[[NSMutableArray alloc]initWithObjects:@"在线留言",@"联系我们",@"二维码扫描",@"版本更新",@"清除缓存",nil];
    nameArray=[[NSMutableArray alloc]initWithObjects:@"使用帮助",@"版本更新",@"清除缓存",nil];
    navigationColor = [UIColor colorWithRed:180/255.0 green:33/255.0 blue:33/255.0 alpha:1];
    aboutObj = [[About alloc]init];
    aboutObj.aboutMeUrl = @"http://192.168.1.208/xmjjdemo/app/uploads/aboutus/12.html";
    aboutObj.frameworkflag = _frameworkflag;
    aboutObj.navigationTitle =CONTACT_US_STR;
    aboutObj.navigationColor = navigationColor;
    aboutObj.framework_1_height_int = framework_1_height_int;
    aboutObj.framework_2_height_int = framework_2_height_int;
    aboutObj.framework_2_defaultX_int = framework_2_defaultX_int;
    
    
    feedBackObj = [[FeedBack alloc]init];
    feedBackObj.frameworkflag = _frameworkflag;
    feedBackObj.navigationTitle = @"";
    feedBackObj.navigationColor = navigationColor;
    feedBackObj.framework_1_height_int = framework_1_height_int;
    feedBackObj.framework_2_height_int = framework_2_height_int;
    feedBackObj.framework_2_defaultX_int = framework_2_defaultX_int;
    
    
    codeVC = [[CodeViewController alloc]init];
    codeVC.navigationTitle = @"二维码扫描";
    codeVC.navigationColor = navigationColor;
}

#pragma mark createview
-(void)createView
{
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
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

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return groupNum1;
    }
    else if(section==1)
    {
        return groupNum2;
    }
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSString *tableIdentifier=@"tableIdentifer";
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreviewControllerTableIdentifer"];
	}
	
	//判断选项
    int nowIndex = 0;
	switch (indexPath.section) {
		case 0:
            nowIndex = indexPath.row;
			break;
		case 1:
            nowIndex = indexPath.row + groupNum1;
			break;
	}
    cell.textLabel.text = [nameArray objectAtIndex:nowIndex];
//    cell.imageView.image = [UIImage imageNamed:[_imgArray objectAtIndex:nowIndex]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
	//实现原角
	[[cell.selectedBackgroundView layer] setBorderWidth:1.5];//画线的宽度
    [[cell.selectedBackgroundView layer] setBorderColor:[UIColor lightGrayColor].CGColor];//颜色
    [[cell.selectedBackgroundView layer] setCornerRadius:6];//圆角
    [cell.selectedBackgroundView.layer setMasksToBounds:YES];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switch (indexPath.section) {
		case 0:
            if(indexPath.row==0)
			{
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:feedBackObj animated:YES];
//                self.hidesBottomBarWhenPushed = NO;
			}
            else if(indexPath.row==1)
			{
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:aboutObj animated:YES];
//                self.hidesBottomBarWhenPushed = NO;
			}
            else if(indexPath.row == 2)
            {
//               self.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:codeVC animated:YES];
//                self.hidesBottomBarWhenPushed = NO;
            }
			
			break;
		case 1:
            if(indexPath.row==0)
			{
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:feedBackObj animated:YES];
//                self.hidesBottomBarWhenPushed = NO;
			}
            else if(indexPath.row==1)
			{
//                self.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:aboutObj animated:YES];
//                self.hidesBottomBarWhenPushed = NO;
			}
            break;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
