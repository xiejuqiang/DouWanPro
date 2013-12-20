//
//  ProduceViewController2.m
//  MainFrame
//
//  Created by Tang silence on 13-6-28.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "Produce2ViewController.h"
#import "EGOImageButton.h"
#import "NewsListDBItem.h"
#import "Constant.h"
#import "ATMHud.h"
#import "ATMHudQueueItem.h"

@interface Produce2ViewController ()

@end

@implementation Produce2ViewController
@synthesize frameworkflag = _frameworkflag;
@synthesize listArray = _listArray;
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


#pragma mark initdata
-(void)initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight=result.height;
}

#pragma mark createview
-(void)createView
{
    //提示框
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //设置view大小
    switch (self.frameworkflag) {
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
    }
    [self.view setBackgroundColor:[UIColor redColor]];
    imgscrollview = [[UIScrollView alloc]init];
    imgscrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:imgscrollview];
    [imgscrollview setCanCancelContentTouches:NO];
    [imgscrollview setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    imgscrollview.showsHorizontalScrollIndicator = NO;
    imgscrollview.showsVerticalScrollIndicator = NO;
    imgscrollview.pagingEnabled = YES;
    imgscrollview.delegate = self;
    imgscrollview.autoresizesSubviews = YES;
    imgscrollview.contentSize = CGSizeMake(320*[self.listArray count], imgscrollview.frame.size.height);
    [imgscrollview setBackgroundColor:[UIColor blackColor]];
}

#pragma mark loadData
- (void)loadData
{
    //假如图片集不存在图片，那么就让它返回前面界面并给出提示
	if([self.listArray count]==0)
	{
		HUD.labelText = @"该图片集没有图片!";
        [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
		//让它除了返回按钮外 其他的都不能操作
	}
	else
	{
        for (int i=0; i<[self.listArray count]; i++) {
            NewsListDBItem *newsListDBItem = [self.listArray objectAtIndex:i];
            EGOImageButton *egoImgView = [[EGOImageButton alloc]initWithPlaceholderImage:[UIImage imageNamed:@"news_left_default"]];
            egoImgView.isUse = YES;
            egoImgView.frame = CGRectMake(imgscrollview.frame.size.width*i, 0, imgscrollview.frame.size.width, 360);
            egoImgView.floatWidth = 320;
            egoImgView.floatHeight = 360;
            [egoImgView setTag:i+100];
            [egoImgView addSubview:egoImgView.egoBtnHud.view];
            [egoImgView.egoBtnHud setActivity:YES];
            [egoImgView.egoBtnHud setActivityStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [egoImgView.egoBtnHud show];
            if(i == 0)
            {
                if([newsListDBItem.thumb isEqualToString:@""] == YES)
                {
                    NSString *strPicURL = [[NSString alloc]initWithFormat:@"%@%@",default_url,newsListDBItem.thumb];
                    egoImgView.imageURL = [NSURL URLWithString:strPicURL];
                }
                
//                [comment setTitle:[NSString stringWithFormat:@"%@评论",detailItem.replies]];
            }
            [imgscrollview addSubview:egoImgView];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, self.view.frame.size.height - 30, 320, 30);
            [button addTarget:self action:@selector(detailbtn:) forControlEvents:UIControlEventTouchUpInside];
            [imgscrollview addSubview:button];
            //            [imgscrollview addSubview:picdetailbtn];
//			//评论数为零的时候，不让他点击
//			if([detailItem.replies isEqualToString:@"0"])
//			{
//				commentNumString=[[NSString alloc]initWithString:@"0"];
//			}
		}
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int min = 0;
    int max = scrollView.contentSize.width;
    int nowx = scrollView.contentOffset.x;
    if(nowx < min && minFlag == NO)
    {
        [self.view addSubview:HUD];
        HUD.labelText = @"已经是第一张了哦~";
        [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
        minFlag = YES;
        min = min - 400;
    }
    if(nowx + scrollView.frame.size.width > max && maxFlag == NO)
    {
        [self.view addSubview:HUD];
        HUD.labelText = @"已经是最后一张了哦~";
        [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
        max = max + 400;
        maxFlag = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    minFlag = NO;
    maxFlag = NO;
    int index = imgscrollview.contentOffset.x/320;
    nowPicIndex = index;
    for(EGOImageButton *egoimgView in scrollView.subviews)
    {
        if(egoimgView.tag -100 == index && egoimgView.imageURL ==nil)
        {
            NewsListDBItem *newsListDBItem = [self.listArray objectAtIndex:egoimgView.tag-100];
			NSString *strPicURL = [[NSString alloc]initWithFormat:@"%@%@",default_url,newsListDBItem.thumb];
			egoimgView.imageURL = [NSURL URLWithString:strPicURL];
        }
    }
    if (index < [self.listArray count]) {
//        NewsListDBItem *item = [self.listArray objectAtIndex:index];
//        picmessage.text = item.description;
    }
}
#pragma mark shleep
- (void)myTask {
	sleep(1.5);
}
#pragma mark load
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
