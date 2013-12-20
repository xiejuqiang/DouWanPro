//
//  FeedBackListViewController.m
//  MainFrame
//
//  Created by apple on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "FeedBackListViewController.h"
#import "Constant.h"
#import "FeedBackListDBItem.h"

@interface FeedBackListViewController ()

@end

@implementation FeedBackListViewController
@synthesize returnDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createTableView
{
    //创建tableview
	mtableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Screen_height-20-49-44) style:UITableViewStylePlain];
	mtableView.delegate=self;
	mtableView.dataSource=self;
    mtableView.separatorStyle = YES;
	//滚动启动（scroll：卷轴）
	mtableView.scrollEnabled=YES;
	mtableView.scrollsToTop=YES;
	//mtableView.separatorColor=[UIColor lightGrayColor];
	//背景颜色清空
	[mtableView setBackgroundColor:[UIColor whiteColor]];
	//把mtableView放到最顶层
	[self.view addSubview:mtableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的反馈";
    [self createTableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview display
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [returnDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row=[indexPath row];
    
    FeedBackListDBItem *item = [returnDataArray objectAtIndex:row];
	NSString *tableIdentifier=@"myFeedBackListTableIde";
	UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"newListTableIde"];
	}
	cell.textLabel.text=item.content;
	cell.textLabel.font=[UIFont fontWithName:@"Arial" size:16];
    
    NSTimeInterval time=[item.dateline doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *postdate = [dateFormatter stringFromDate:detaildate];
	cell.detailTextLabel.text=postdate;
	cell.detailTextLabel.font=[UIFont fontWithName:@"Arial" size:10];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45;
}

@end
