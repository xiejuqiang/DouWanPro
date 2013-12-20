//
//  MenuCell.h
//  CoverStyle
//
//  Created by apple on 13-7-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
{
    UIImageView *bgImg;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuPicName:(NSString *)_menuPicName menuName:(NSString *)_menuName;

@end
