//
//  NewsListCell2.h
//  MainFra
//
//  Created by Tang silence on 13-6-26.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@interface NewsList2Cell : UITableViewCell
{
	UILabel *titleLabel;
	UILabel *descripLabel;
    EGOImageView *itemImageView; //EGOImageView
    UIView *vv;//显示shadow的view
}
-(void) setImgStr:(NSString*)imgStr;
-(void) setTitleLabelText:(NSString *)titleText;
-(void) setDescripLabelText:(NSString *)descripText;
- (void)addShadowToCellInTableView:(UITableView *)tableView
                       atIndexPath:(NSIndexPath *)indexPath;
@end
