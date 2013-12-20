//
//  SplashViewController.h
//  MainFrame
//
//  Created by Tang silence on 13-7-8.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SplashViewController : UIViewController
{
    NSTimer *timer;
    UIImageView *splashImageView;
    
    AppDelegate *viewController;
}
@end
