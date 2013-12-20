//
//  NewsListCell1.h
//  MainFra
//
//  Created by Tang silence on 13-6-25.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@interface NewsList1Cell : UITableViewCell
{
	UILabel *titleLabel;
	UILabel *descripLabel;
    EGOImageView *itemImageView; //EGOImageView
}
-(void) setImgStr:(NSString*)imgStr;
-(void) setTitleLabelText:(NSString *)titleText;
-(void) setDescripLabelText:(NSString *)descripText;
@end
