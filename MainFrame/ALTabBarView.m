//
//  ALTabBarView.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarView.h"


@implementation ALTabBarView

@synthesize delegate;
@synthesize selectedButton;
@synthesize tabbarTitleArray;

- (void)dealloc {
    
    [selectedButton release];
    delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code

    }
    return self;
}

- (void)createButton
{
    for (int i = 0; i< 5; i++)
    {
        selectedButton = [[DIYButton alloc] initWithFrame:CGRectMake(64*i, 0, 64, 49)];
        selectedButton.titleArr = self.tabbarTitleArray;
        [selectedButton setPicAndTitle:i];
        selectedButton.tag = 100 +i;
        [selectedButton setBackgroundImage:[UIImage imageNamed:@"b_2_bg.png"] forState:UIControlStateNormal];
        [selectedButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectedButton];
        if (i == 0) {
            tempButton = selectedButton;
        }
    }
    [self touchButton:tempButton];
}

//Let the delegate know that a tab has been touched
-(void) touchButton:(id)sender {

    if( delegate != nil && [delegate respondsToSelector:@selector(tabWasSelected:)]) {
        
        if (selectedButton) {
            [selectedButton setBackgroundImage:[UIImage imageNamed:@"b_2_bg.png"] forState:UIControlStateNormal];
            [selectedButton release];
            NSString *imgStr = [[NSString alloc] initWithFormat:@"b_2_b%d.png",selectedButton.tag-100+1];
            selectedButton.item_imageView.image = [UIImage imageNamed:imgStr];
            selectedButton.item_title.textColor = [UIColor grayColor];
        
        }
        
        selectedButton = [((DIYButton *)sender) retain];
        [selectedButton setBackgroundImage:[UIImage imageNamed:@"b_2_bg_se.png"] forState:UIControlStateNormal];
        NSString *imgStr = [[NSString alloc] initWithFormat:@"b_2_b%d_se.png",selectedButton.tag-100+1];
        selectedButton.item_imageView.image = [UIImage imageNamed:imgStr];
        selectedButton.item_title.textColor = [UIColor redColor];
        [delegate tabWasSelected:selectedButton.tag-100];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
