//
//  ALTabBarController.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarController.h"
#define Screen_height   [[UIScreen mainScreen] bounds].size.height

@implementation ALTabBarController

@synthesize customTabBarView;
@synthesize tabbarTitleArray;

- (void)dealloc {
    
    [customTabBarView release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideExistingTabBar];
    
//    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil];
//    self.customTabBarView = [nibObjects objectAtIndex:0];
    self.customTabBarView = [[ALTabBarView alloc] initWithFrame:CGRectMake(0, Screen_height-49, 320, 49)];
//    self.customTabBarView.backgroundColor = [UIColor redColor];
    self.customTabBarView.delegate = self;
    self.customTabBarView.tabbarTitleArray = self.tabbarTitleArray;
    [self.customTabBarView createButton];
    [self.view addSubview:self.customTabBarView];
}

- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

#pragma mark ALTabBarDelegate

-(void)tabWasSelected:(NSInteger)index {
 
    self.selectedIndex = index;
}


@end
