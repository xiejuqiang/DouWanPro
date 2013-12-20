//
//  Constant.h
//  MainFrame
//
//  Created by Tang silence on 13-6-27.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#define framework_flag 4   //1 tabbar方式 2 列表方式 3 首页列表 4 首页按钮
#define news_flag 1 //1    2列表
#define produce_flag 1//1列表  2 图片
#define appId @"35"
#define codeC 1  //主框架模块个数 跟服务器获取相差


#define framework_1_height (20 + 44 + 48)
#define framework_2_height (20 + 44)
#define framework_2_defaultX 44

//#define DEFAULT_URL @"http://192.168.1.208/xmjjdemo/app/" //内网地址
#define DEFAULT_IMG_URL @"http://192.168.1.208"

#define DEFAULT_URL @"http://appmk.medp.cn/app/" //外网地址
#define DEFAULT_ABOUT_URL @"http://appmk.medp.cn/"

#define ABOUT_US @"关于我们"
#define FEEDBACK @"问题反馈"
#define NEWSLIST @"新闻"
#define PRODUCE @"产品"
#define TEXTVIEW_DEFAULT_TEXT @"请输入反馈问题"
#define POST @"反馈列表"


//xie
#ifndef CoverStyle_constants_h
#define CoverStyle_constants_h

#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define NAVBAR_TITLE_STR @"首页"
//frame 3
#define NAV_BACKGROUND_IMG @"nav_background.png"

#define COMPANY_PROFILE_IMG @"company_profile.png"
#define NEWS_TRENDS_IMG @"news_trends.png"
#define PRODUCT_DISPLAY_IMG @"product_display.png"
#define ONLINE_MESSAGE_IMG @"online_message.png"
#define CONTACT_US_IMG @"contact_us.png"

#define COMPANY_PROFILE_STR @"公司简介"
#define NEWS_TRENDS_STR @"新闻公告"
#define PRODUCT_DISPLAY_STR @"产品展示"
#define ONLINE_MESSAGE_STR @"在线留言"
#define CONTACT_US_STR @"联系我们"

//frame4
//#define NAV_BACKGROUND_IMG @"navBackground.png"
#define MENU_BACKGROUND_IMG @"menuBackground.png"

#define COMPANY_PROFILE_PNG @"companyProfile.png"
#define NEWS_TRENDS_PNG @"newsTrends.png"
#define PRODUCT_DISPLAY_PNG @"productDisplay.png"
#define ONLINE_MESSAGE_PNG @"onlineMessage.png"
#define CONTACT_US_PNG @"contactUs.png"
#define QRPICTURE_PNG @"QRPicture.png"


#define APP_URL @""

#endif
