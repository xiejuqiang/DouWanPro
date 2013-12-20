//
//  HotNewsView.m
//  CoverStyleDemo
//
//  Created by apple on 13-7-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HotNewsView.h"
#import "EGOImageView.h"
#import "Constant.h"

@implementation HotNewsView
@synthesize hotNewsDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)startTimer
{
    //add timer
    // 安装timer（注册timer）
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval: 1// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                 target: self
                                               selector: @selector(handleTimer)
                                               userInfo: nil
                                                repeats: YES]; // 如果是NO 不重复，则timer在触发了回调函数调用完成之后 会自动释放这个timer，以免timer被再一次的调用，如果是YES，则会重复调用函数，调用完函数之后，会将这个timer加到RunLoop中去，等待下一次的调用，知道用户手动释放timer( [timer invalidate];)。
        
        [timer fire];
    }
}

- (void)destoryTimer
{
    [timer invalidate];
    timer = nil;
}

- (void)handleTimer
{
    if (TimeNum % 3 == 0 ) {
        
        if (!Tend) {
            pageControl.currentPage++;
            if (pageControl.currentPage==pageControl.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            pageControl.currentPage = 0;
            Tend=NO;
            
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             topLineScroll.contentOffset = CGPointMake(pageControl.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}


- (void)createScrollView:(int)pageNum thumbArr:(NSArray *)thumb thumbIDArr:(NSArray *)thumbID
{
    topLineScroll = [[UIScrollView alloc] init];
    topLineScroll.frame = self.frame;
    [self addSubview:topLineScroll];
    topLineScroll.delegate = self;
    topLineScroll.pagingEnabled = YES;
    topLineScroll.showsHorizontalScrollIndicator = NO;
    topLineScroll.bounces = NO;
    topLineScroll.contentSize = CGSizeMake(self.frame.size.width*pageNum, self.frame.size.height);
    
    //pageControl backView
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:v];
    v.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-7.5);
    
    //Initial PageView
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    pageControl.numberOfPages = pageNum;
    //    [pageControl sizeToFit];
    
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    pageControl.center = v.center;
    

    for (int i = 0; i<pageNum; i++) {
        NSString *str = [thumb objectAtIndex:i];
        EGOImageView *scrollImageView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"scroll_bg"]];
        scrollImageView.userInteractionEnabled = YES;
        scrollImageView.isUse = NO;
        scrollImageView.contentMode = UIViewContentModeScaleAspectFill;
        if([str isEqualToString:DEFAULT_IMG_URL] == NO)
            scrollImageView.imageURL = [NSURL URLWithString:str];
        scrollImageView.frame = CGRectMake(320*i, 0, 320, topLineScroll.frame.size.height);
        [topLineScroll addSubview:scrollImageView];
        if (thumbID != nil)
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHomeNews:)];
            [scrollImageView addGestureRecognizer:tap];
            tap.view.tag = [[thumbID objectAtIndex:i] intValue];
            
        }
    }

}

- (void)TapHomeNews:(UIGestureRecognizer *)recongnizer
{
    if ([hotNewsDelegate respondsToSelector:@selector(homeNewDetail:)]) {
        [hotNewsDelegate homeNewDetail:recongnizer.view.tag];
    }
}

#pragma mark -
#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offset = scrollView.contentOffset.x/320.0;
    pageControl.currentPage = offset;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
