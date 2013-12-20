//
//  NewsListCell2.m
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "NewsList2Cell.h"
#import "EGOImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation NewsList2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        vv = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0, 301, 245)];
        vv.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:vv];
        itemImageView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"news_left_default.jpg"]]; //EGOImageView
        itemImageView.frame = CGRectMake(8, 10, 285, 153);
        [self.contentView addSubview:itemImageView];
        //标题
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 173-3, 285, 25)];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        //描述
        descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 208-5, 285, 37)];
        descripLabel.font = [UIFont fontWithName:@"Arial" size:14];
        descripLabel.textColor = [UIColor lightGrayColor];
        descripLabel.numberOfLines = 2;
        [self.contentView addSubview:descripLabel];
        
    }
    return self;
}

-(void) setImgStr:(NSString*)imgStr
{
    itemImageView.isUse = NO;
    itemImageView.imageURL = [[NSURL alloc] initWithString:imgStr];
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

/** adds a drop shadow to the background view of the (grouped) cell */
- (void)addShadowToCellInTableView:(UITableView *)tableView
                       atIndexPath:(NSIndexPath *)indexPath
{
    BOOL isFirstRow = !indexPath.row;
    //    BOOL isLastRow = (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1);
    
    // the shadow rect determines the area in which the shadow gets drawn
    CGRect shadowRect = CGRectInset(vv.bounds, 0, -10);
    if(isFirstRow)
        shadowRect.origin.y += 10;
    shadowRect.size.height -= 10;
    //    else if(isLastRow)
    
    
    // the mask rect ensures that the shadow doesn't bleed into other table cells
    CGRect maskRect = CGRectInset(vv.bounds, -20, -1);
    if(isFirstRow) {
        maskRect.origin.y -= 10;
        maskRect.size.height += 10;
        
    }
    //    else if(isLastRow)
    
    
    // now configure the background view layer with the shadow
    CALayer *layer = vv.layer;
    layer.shadowColor = [UIColor colorWithRed:203/255 green:203/255 blue:203/255 alpha:1].CGColor;
    //    layer.shadowColor = [UIColor redColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 1;//阴影半径 default 3
    layer.shadowOpacity = 0.35;//阴影透明度[0,1]
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:0].CGPath;
    layer.masksToBounds = NO;
    
    // and finally add the shadow mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:maskRect].CGPath;
    layer.mask = maskLayer;
}

@end
