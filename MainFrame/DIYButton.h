//
//  DIYButton.h
//  ALCommon
//
//  Created by apple on 13-10-8.
//
//

#import <UIKit/UIKit.h>

@interface DIYButton : UIButton
{
    NSArray *titleArr;
}

@property (nonatomic, retain)  UIImageView *item_imageView;
@property (nonatomic, retain)  UILabel *item_title;
@property (nonatomic, retain)  NSArray *titleArr;
- (void)setPicAndTitle:(int)index;
@end
