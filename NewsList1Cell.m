//
//  NewsListCell1.m
//  MainFra
//
//  Created by Tang silence on 13-6-25.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsList1Cell.h"
#import "EGOImageView.h"

@implementation NewsList1Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        itemImageView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"news_left_default.png"]]; //EGOImageView
        itemImageView.frame = CGRectMake(8, 10, 80, 60);
        [self.contentView addSubview:itemImageView];
        //标题
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(104, 5, 196, 22)];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        //描述
        descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(104, 25, 196, 37)];
        descripLabel.font = [UIFont fontWithName:@"Arial" size:14];
        descripLabel.textColor = [UIColor lightGrayColor];
        descripLabel.numberOfLines = 2;
        [self.contentView addSubview:descripLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setTitleLabelText:(NSString *)titleText
{
    titleLabel.text = titleText;
}
-(void) setDescripLabelText:(NSString *)descripText
{
    descripLabel.text = descripText;
}
-(void) setImgStr:(NSString*)imgStr
{
    itemImageView.isUse = NO;
    itemImageView.imageURL = [[NSURL alloc] initWithString:imgStr];
}

@end
