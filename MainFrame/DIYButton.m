//
//  DIYButton.m
//  ALCommon
//
//  Created by apple on 13-10-8.
//
//

#import "DIYButton.h"
#import "UIView+UIViewEx.h"

@implementation DIYButton
@synthesize item_imageView = _item_imageView;
@synthesize item_title = _item_title;
@synthesize titleArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        titleArr = @[@"首页",@"公司简介",@"新闻动态",@"产品展示",@"更多"];
        
    }
    return self;
}

- (void)setPicAndTitle:(int)index
{
    //create imgview
    NSString *imgStr = [[NSString alloc] initWithFormat:@"b_2_b%d",index+1];
    
    _item_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
    _item_imageView.top = 2;
    _item_imageView.left = 20;
    _item_title = [[UILabel alloc] initWithFrame:CGRectMake(0, _item_imageView.bottom+1, 64, 22)];
    _item_title.text = [titleArr objectAtIndex:index];
    _item_title.textColor = [UIColor grayColor];
    //    _item_title.center = self.center;
    _item_title.font = [UIFont systemFontOfSize:13.0];
    _item_title.backgroundColor = [UIColor clearColor];
    _item_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_item_imageView];
    [self addSubview:_item_title];
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
