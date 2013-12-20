//
//  About.m
//  About
//
//  Created by Tang silence on 13-6-18.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "MainFramDragViewController.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import <QuartzCore/CALayer.h>

#define CENTER 160.0

//@interface MainFramDragViewController ()
//{
//    BOOL isAppear;
//    CGPoint startPoint;
//}
//@end

@implementation MainFramDragViewController

@synthesize aboutMeUrl = _aboutMeUrl;
@synthesize list = _list;
@synthesize listView = _listView;
@synthesize drawerView = _drawerView;
//@synthesize frameworkflag = _frameworkflag;
@synthesize viewArray;

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
    //self.list = @[@"关于我们",@"问题反馈",@"新闻",@"产品"];
    self.list = [[NSArray alloc] initWithObjects:@"关于我们",@"问题反馈",@"新闻",@"产品", nil];
}
-(void)createView
{

    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.listView.rowHeight = 44;
    self.listView.sectionHeaderHeight = 22;
    self.listView.sectionFooterHeight = 22;
    self.listView.backgroundColor = [UIColor colorWithRed:110/255.0 green:123/255.0 blue:139/255.0 alpha:1.0];
    self.listView.separatorColor = [UIColor grayColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    [self.view addSubview:self.listView];
    
    self.drawerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:self.drawerView];
    //加入显示内容页
    self.drawerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.drawerView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.drawerView.layer.shadowOpacity = 1.0;
    self.drawerView.layer.shadowRadius = 15.0;
    self.drawerView.backgroundColor = [UIColor whiteColor];
    [self.drawerView setAutoresizesSubviews:YES];
    
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *barItem = [[UINavigationItem alloc]init];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]init];
    barButtonItem.title = @"详情";
    [barButtonItem setAction:@selector(buttonCLicked:)];
    
    barItem.leftBarButtonItem = barButtonItem;
    [self.navBar pushNavigationItem:barItem animated:YES];
    
    self.navBar.topItem.title = ABOUT_US;
    self.navBar.tintColor = [UIColor colorWithRed:24/255.0 green:116/255.0 blue:205/255.0 alpha:1.0];//24 116 205
    
   // [_drawerView addSubview:_navBar];
//    [_drawerView addSubview:((UIViewController *)[viewArray objectAtIndex:1]).view];
    [_drawerView addSubview:((UIViewController *)[viewArray objectAtIndex:0]).view];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
}
/*
-(void)swipe:(UIPanGestureRecognizer *)g{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)g;
    if(pan.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [pan locationInView:self.drawerView];
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [pan locationInView:self.drawerView];
        CGFloat dx = point.x - startPoint.x;
        
        CGPoint currentCenter = CGPointMake(self.drawerView.center.x+dx,self.drawerView.center.y);
        if (currentCenter.x > CENTER)
        {
            [self.drawerView setCenter:currentCenter];
        }
    }
    else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if (isAppear)
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(200, 0, 320, 460)];
            }];
            isAppear = NO;
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
            }];
            isAppear = YES;
        }
    }
}
 */
- (IBAction)buttonCLicked:(id)sender
{
    if (isAppear)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
        }];
        isAppear = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.drawerView setFrame:CGRectMake(200, 0, 320, 460)];
        }];
        isAppear = YES;
    }
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.drawerView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.drawerView];
    CGFloat dx = point.x - startPoint.x;
    
    CGPoint currentCenter = CGPointMake(self.drawerView.center.x+dx,self.drawerView.center.y);
    if (currentCenter.x > CENTER)
    {
        [self.drawerView setCenter:currentCenter];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount !=0)
    {
        return;
    }
    else
    {
        if (isAppear)
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(200, 0, 320, 460)];
            }];
            isAppear = NO;
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
            }];
            isAppear = YES;
        }
    }
}
*/
#pragma mark- UITableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"• %@",[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.indexPathForSelectedRow == indexPath)
    {
        return;
    }
//    self.view.window.rootViewController = feedback;
    //    [self.navigationController pushViewController:feedback animated:YES];
    
    self.navBar.topItem.title = [self.list objectAtIndex:indexPath.row];
//    [self.view addSubview:self.listView];
    [self.drawerView addSubview:((UIViewController *)[viewArray objectAtIndex:indexPath.row]).view];
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.drawerView setFrame:CGRectMake(320, 0, 320, 460)];
        [self performSelector:@selector(drawerViewAppear) withObject:nil afterDelay:0.5];
    }];
}

- (void)drawerViewAppear
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.drawerView setFrame:CGRectMake(0, 0, 320, 460)];
    }];
    isAppear = NO;
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
