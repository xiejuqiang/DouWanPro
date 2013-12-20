//
//  HotNewsView.h
//  CoverStyleDemo
//
//  Created by apple on 13-7-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

@protocol HotNewsDelegate <NSObject>

- (void)homeNewDetail:(int)hotNesID;

@end

#import <UIKit/UIKit.h>

@interface HotNewsView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *topLineScroll;
    UIPageControl *pageControl;
    NSTimer *timer;
    int TimeNum;
    BOOL Tend;
    
}

@property(nonatomic,assign)id<HotNewsDelegate> hotNewsDelegate;

- (void)createScrollView:(int)pageNum thumbArr:(NSArray *)thumb thumbIDArr:(NSArray *)thumbID;
- (void)startTimer;
- (void)destoryTimer;

@end

