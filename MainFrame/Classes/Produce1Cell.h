//
//  Produce1Cell.h
//  MainFrame
//
//  Created by Tang silence on 13-7-4.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;

@interface Produce1Cell : UITableViewCell
{
	UILabel *titleLabel;
	UILabel *descripLabel;
    EGOImageView *itemImageView; //EGOImageView
}
-(void) setImgStr:(NSString*)imgStr;
-(void) setTitleLabelText:(NSString *)titleText;
-(void) setDescripLabelText:(NSString *)descripText;
@end
