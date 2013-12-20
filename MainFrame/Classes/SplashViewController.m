//
//  SplashViewController.m
//  MainFrame
//
//  Created by Tang silence on 13-7-8.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark loadView

- (void)loadView
{
    CGRect appFrame = [[UIScreen mainScreen]applicationFrame];
    UIView *view = [[UIView alloc]initWithFrame:appFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.view = view;
    
    splashImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Splash.png"]];
    splashImageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:splashImageView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
}

- (void)fadeScreen
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedFading)];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)finishedFading
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    self.view.alpha = 1.0;
    [UIView commitAnimations];
    [splashImageView removeFromSuperview];
}
@end
