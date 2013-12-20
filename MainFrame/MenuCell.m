//
//  MenuCell.m
//  CoverStyle
//
//  Created by apple on 13-7-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MenuCell.h"
#import "Constant.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuPicName:(NSString *)_menuPicName menuName:(NSString *)_menuName
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background_ios4"]];
        if (iPhone5)
        {
//            bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background_ios5"]];
            arrow.frame = CGRectMake(320-34, 21, 14, 15);
        }
        else
        {
//           bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_background_ios4"]]; 
           arrow.frame = CGRectMake(320-34, 17, 14, 15);
            
        }
        
        self.backgroundView = bgImg;
        [self addSubview:arrow];
        [self createImageView:_menuPicName];
        [self createLabel:_menuName];
    }
    return self;
}

- (void)createImageView:(NSString *)name
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    if (iPhone5)
    {
        image.frame = CGRectMake(20, 13.5, 30, 30);
    }
    else
    {
        image.frame = CGRectMake(20, 9.5, 30, 30); 
    }
    
    [self addSubview:image];
}

- (void)createLabel:(NSString *)name
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 200, 49)];
    [self addSubview:label];
    label.text = name;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:1];
    label.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
