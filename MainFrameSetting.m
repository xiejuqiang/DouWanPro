//
//  MainFrameSetting.m
//  MainFra
//
//  Created by Tang silence on 13-6-21.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "MainFrameSetting.h"
#import "Constant.h"
#import "About.h"
#import "AppDelegate.h"
#import "FeedBack.h"
#import "NewsList1ViewController.h"
#import "NewsList2ViewController.h"
#import "Produce1ViewController.h"
#import "Produce2ViewController.h"
//数据库相关
#import "RecordDao.h"
#import "SystemConfigDBItem.h"

#import "UrlStr.h"
#import "GetObj.h"

#import "JsonParser.h"

//mainFram
#import "StyleViewController.h"
#import "CoverViewController.h"
#import "CodeViewController.h"

//主页属性
#import "MenuAttribute.h"

#import "MoreViewController.h"


@implementation MainFrameSetting
@synthesize systemSettingArray;
//@synthesize systemSettingDic;
//@synthesize netWorkFlag;


- (id)init
{
    if(self = [super init])
    {
        [self initColor];
        _myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        recordDB = [[RecordDao alloc]init];
        urlStr = [[UrlStr alloc]init];
        [recordDB createDB:DATABASE_NAME];
        allFramArray = [[NSArray alloc] initWithObjects:@"Layout",@"MoNews",@"MoProduct",@"MoPicture",@"MoMessage",@"MoContact",@"MoProfile",@"MoQrcode", nil];
      //  allFramArray = @[@"Layout",@"MoNews",@"MoProduct",@"MoPicture",@"MoMessage",@"MoContact",@"MoProfile",@"MoQrcode"];
        
//        menuStylePicNameArr = [[NSMutableDictionary alloc]init];
//        menuNameArr = [[NSMutableDictionary alloc]init];
//        menuCoverPicNameArr = [[NSMutableDictionary alloc]init];
//        menuAttributeArray = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)initColor
{
//    navigationColor = [UIColor colorWithRed:143/255.0 green:196/255.0 blue:0/255.0 alpha:1];
//    navigationColor = [UIColor colorWithRed:173/255.0 green:48/255.0 blue:16/255.0 alpha:1];
//    navigationColor = [UIColor colorWithRed:150/255.0 green:30/255.0 blue:20/255.0 alpha:1];
    navigationColor = [UIColor colorWithRed:180/255.0 green:33/255.0 blue:33/255.0 alpha:1];
}
- (void)openUI
{
    
    for (SystemConfigDBItem *systemDBItem in systemSettingArray) {
        int index = [allFramArray  indexOfObject:systemDBItem.cloKey];
        if (index == 0) {
            layout_flag = [systemDBItem.cloValue intValue] + homeModel;
            ((AppDelegate *)[UIApplication sharedApplication].delegate).layout_flag = layout_flag;
            break;
        }
    }
    switch (layout_flag) {
        case 1:
        {
            _myDelegate.tabbarArray = [self creatTabbar];
        }
            break;
        case 2:
        {
//             _myDelegate.tabbarArray = [self createViewArray];
        }
            break;
        case 3:
        {
            StyleViewController *vc = [[StyleViewController alloc] init];
            vc.menuAttributeArray = [self createViewArray];
            vc.systemSettingArray = systemSettingArray;
            UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:vc];
            _nav.navigationBar.tintColor = navigationColor;
            _myDelegate.nav = _nav;
        }
            break;
        case 4:
        {
            CoverViewController *vc = [[CoverViewController alloc] init];
            vc.menuAttributeArray = [self createViewArray];
//            vc.btnPicNameArr = menuCoverPicNameArr;
//            vc.labelNameArr = menuNameArr;
            vc.systemSettingArray = systemSettingArray;
            UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:vc];
            _myDelegate.nav = _nav;
            _nav.navigationBar.tintColor = navigationColor;
            
        }
            break;
    }
}
-(NSMutableArray *)creatTabbar
{
    

    CoverViewController *coverVC = [[CoverViewController alloc] init];
    coverVC.aboutMeUrl = @"http://www.baidu.com";
    coverVC.frameworkflag = layout_flag;
    coverVC.framework_1_height_int = framework_1_height;
    coverVC.framework_2_height_int = framework_2_height;
    coverVC.framework_2_defaultX_int = framework_2_defaultX;
    coverVC.navigationColor = navigationColor;
    coverVC.navigationTitle = @"首页";
    //特有
    coverVC.menuAttributeArray = [self createViewArray];
    coverVC.systemSettingArray = systemSettingArray;
    
    UINavigationController *coverNaC = [[UINavigationController alloc]initWithRootViewController:coverVC];
    coverNaC.tabBarItem.title = @"首页";
    
    GetObj *getO = [[GetObj alloc]init];
    About *aboutObj = [[About alloc]init];
    
    NewsList2ViewController *newsList1VC = [[NewsList2ViewController alloc]init];
    
    //产品
    Produce1ViewController *produce1VC = [[Produce1ViewController alloc]init];
    
    for (SystemConfigDBItem *systemDBItem in systemSettingArray)
    {
        
        int index = [allFramArray  indexOfObject:systemDBItem.cloKey];
        
        switch (index) {
            case MoProfile:
            {
                getO.catid = systemDBItem.classN;
                NSString *aboutCategoryURL = [urlStr returnURL:52 Obj:getO];
                
                //该frame专有
                aboutObj.navigationColor = navigationColor;
                aboutObj.navigationTitle = systemDBItem.note;
                //各个frame都有
                aboutObj.aboutMeUrl = aboutCategoryURL;
                aboutObj.frameworkflag = layout_flag;
                aboutObj.framework_1_height_int = framework_1_height;
                aboutObj.framework_2_height_int = framework_2_height;
                aboutObj.framework_2_defaultX_int = framework_2_defaultX;
                
                aboutMeNaC = [[UINavigationController alloc]initWithRootViewController:aboutObj];
                aboutMeNaC.tabBarItem.title = systemDBItem.note;
            }
                break;
            case MoNews:
            {
                //该frame专有
                newsList1VC.navigationTitle = systemDBItem.note;
                newsList1VC.navigationColor = navigationColor;
                //各个frame都有
                //    newsList1VC.HUD = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).HUD;
                newsList1VC.frameworkflag = layout_flag;
                newsList1VC.default_url = DEFAULT_ABOUT_URL;
                newsList1VC.framework_1_height_int = framework_1_height;
                newsList1VC.framework_2_height_int = framework_2_height;
                newsList1VC.framework_2_defaultX_int = framework_2_defaultX;
                newsList1NaC = [[UINavigationController alloc]initWithRootViewController:newsList1VC];
                newsList1NaC.tabBarItem.title = systemDBItem.note;
                
                
            }
                break;
            case MoProduct:
            {
                //该frame专有
                produce1VC.navigationTitle = systemDBItem.note;
                produce1VC.navigationColor = navigationColor;
                //各个frame都有
                produce1VC.frameworkflag = layout_flag;
                produce1VC.default_url = DEFAULT_ABOUT_URL;
                produce1VC.step = 1;
                produce1VC.framework_1_height_int = framework_1_height;
                produce1VC.framework_2_height_int = framework_2_height;
                produce1VC.framework_2_defaultX_int = framework_2_defaultX;
                
                produce1NaC = [[UINavigationController alloc]initWithRootViewController:produce1VC];
                produce1NaC.tabBarItem.title = systemDBItem.note;
            }
                break;
                
            default:
                break;
        }
        

    }
    
   
    _myDelegate.tabbarTitleArray = [[NSArray alloc] initWithObjects:@"首页",aboutMeNaC.tabBarItem.title,newsList1NaC.tabBarItem.title,produce1NaC.tabBarItem.title,@"更多", nil];
   // _myDelegate.tabbarTitleArray = @[@"首页",aboutMeNaC.tabBarItem.title,newsList1NaC.tabBarItem.title,produce1NaC.tabBarItem.title,@"更多"];
   
    //    UIImage *imageTab1 = [[UIImage alloc] initWithContentsOfFile:
    //                          [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icon_tabbar_1.png"]];
    //    aboutMeNaC.tabBarItem.image = imageTab1;
    
    FeedBack *feedBackObj = [[FeedBack alloc]init];
    //该frame专有
    feedBackObj.navigationColor = navigationColor;
    feedBackObj.navigationTitle = FEEDBACK;
    //各个frame都有
    feedBackObj.frameworkflag = layout_flag;
    feedBackObj.framework_1_height_int = framework_1_height;
    feedBackObj.framework_2_height_int = framework_2_height;
    feedBackObj.framework_2_defaultX_int = framework_2_defaultX;
    
    UINavigationController *feedBackNaC = [[UINavigationController alloc]initWithRootViewController:feedBackObj];
    feedBackNaC.tabBarItem.title = FEEDBACK;
    
    
   
  
    
    
   
    NewsList2ViewController *newsList2VC = [[NewsList2ViewController alloc]init];
    //该frame专有
    newsList2VC.navigationTitle = NEWSLIST;
    newsList2VC.navigationColor = navigationColor;
    //各个frame都有
    newsList2VC.frameworkflag = layout_flag;
    newsList2VC.default_url = DEFAULT_IMG_URL;
    newsList2VC.framework_1_height_int = framework_1_height;
    newsList2VC.framework_2_height_int = framework_2_height;
    newsList2VC.framework_2_defaultX_int = framework_2_defaultX;
    
    UINavigationController *newsList2NaC = [[UINavigationController alloc]initWithRootViewController:newsList2VC];
    newsList2NaC.tabBarItem.title = NEWSLIST;
    
    
   
    
   
    
    
    //产品
    Produce2ViewController *produce2VC = [[Produce2ViewController alloc]init];
    //该frame专有
    produce2VC.navigationTitle = PRODUCE;
    produce2VC.navigationColor = navigationColor;
    //各个frame都有
    produce2VC.frameworkflag = layout_flag;
    produce2VC.default_url = DEFAULT_IMG_URL;
    produce2VC.framework_1_height_int = framework_1_height;
    produce2VC.framework_2_height_int = framework_2_height;
    produce2VC.framework_2_defaultX_int = framework_2_defaultX;
    
    UINavigationController *produce2NaC = [[UINavigationController alloc]initWithRootViewController:produce2VC];
    produce2NaC.tabBarItem.title = PRODUCE;
    
    //公司简介
    Produce1ViewController *produceVC = [[Produce1ViewController alloc]init];
    //该frame专有
    produceVC.navigationTitle = PRODUCE;
    produceVC.navigationColor = navigationColor;
    //各个frame都有
    produceVC.frameworkflag = layout_flag;
    produceVC.default_url = DEFAULT_IMG_URL;
    produceVC.framework_1_height_int = framework_1_height;
    produceVC.framework_2_height_int = framework_2_height;
    produceVC.framework_2_defaultX_int = framework_2_defaultX;
    
    UINavigationController *produceNaC = [[UINavigationController alloc]initWithRootViewController:produceVC];
    produceNaC.tabBarItem.title = @"公司简介";
    
    
    
    //更多
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    //该frame专有
    moreVC.navigationTitle = @"更多";
    moreVC.navigationColor = navigationColor;
    //各个frame都有
    moreVC.frameworkflag = layout_flag;
    moreVC.default_url = DEFAULT_IMG_URL;
    moreVC.framework_1_height_int = framework_1_height;
    moreVC.framework_2_height_int = framework_2_height;
    moreVC.framework_2_defaultX_int = framework_2_defaultX;
    
    UINavigationController *moreNaC = [[UINavigationController alloc]initWithRootViewController:moreVC];
    moreNaC.tabBarItem.title = @"更多";
    
    
    
    id newslist = nil;
    switch (news_flag) {
        case 1:
            newslist = newsList1NaC;
            break;
        case 2:
            newslist = newsList2NaC;
            break;
    }
    
    id produce = nil;
    switch (produce_flag) {
        case 1:
            produce = produce1NaC;
            break;
        case 2:
            produce = produce2NaC;
            break;
    }
    
   
    
    [coverNaC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"b_2_b1_se.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_2_b1.png"]];
    [aboutMeNaC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"b_2_b2_se.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_2_b2.png"]];
    [((UINavigationController *)newslist).tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"b_2_b3_se.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_2_b3.png"]];
    [((UINavigationController *)produce).tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"b_2_b4_se.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_2_b4.png"]];
    [moreNaC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"b_2_b5_se.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"b_2_b5.png"]];
   
    NSMutableArray *tabbarArray=[[NSMutableArray alloc]initWithObjects:coverNaC,aboutMeNaC,newslist,produce,moreNaC,nil];
    
    return tabbarArray;
}
- (NSMutableDictionary *)createViewArray
{

    GetObj *getO = [[GetObj alloc]init];
    
    About *aboutObj = [[About alloc]init];
    
    aboutObj.frameworkflag = layout_flag;
    aboutObj.navigationColor = navigationColor;
    aboutObj.framework_1_height_int = framework_1_height;
    aboutObj.framework_2_height_int = framework_2_height;
    aboutObj.framework_2_defaultX_int = framework_2_defaultX;

    
    FeedBack *feedBackObj = [[FeedBack alloc]init];
    feedBackObj.frameworkflag = layout_flag;
    feedBackObj.navigationColor = navigationColor;
    feedBackObj.framework_1_height_int = framework_1_height;
    feedBackObj.framework_2_height_int = framework_2_height;
    feedBackObj.framework_2_defaultX_int = framework_2_defaultX;

    
    NewsList1ViewController *newsList1VC = [[NewsList1ViewController alloc]init];
    newsList1VC.frameworkflag = layout_flag;
    newsList1VC.navigationColor = navigationColor;
    newsList1VC.default_url = DEFAULT_ABOUT_URL;
    newsList1VC.framework_1_height_int = framework_1_height;
    newsList1VC.framework_2_height_int = framework_2_height;
    newsList1VC.framework_2_defaultX_int = framework_2_defaultX;
    
    NewsList2ViewController *newslist2VC = [[NewsList2ViewController alloc]init];
    newslist2VC.frameworkflag = layout_flag;
    newslist2VC.navigationTitle = NEWSLIST;
    newslist2VC.navigationColor = navigationColor;
    newslist2VC.default_url = DEFAULT_IMG_URL;
    newslist2VC.framework_1_height_int = framework_1_height;
    newslist2VC.framework_2_height_int = framework_2_height;
    newslist2VC.framework_2_defaultX_int = framework_2_defaultX;
    
    //产品
    Produce1ViewController *produce1VC = [[Produce1ViewController alloc]init];
    produce1VC.navigationTitle = @"产品展示";
    produce1VC.navigationColor = navigationColor;
    produce1VC.frameworkflag = layout_flag;
    produce1VC.step = 1;
    produce1VC.default_url = DEFAULT_ABOUT_URL;
    produce1VC.framework_1_height_int = framework_1_height;
    produce1VC.framework_2_height_int = framework_2_height;
    produce1VC.framework_2_defaultX_int = framework_2_defaultX;
    
    Produce2ViewController *produce2VC = [[Produce2ViewController alloc]init];
    produce2VC.navigationTitle = PRODUCE;
    produce2VC.navigationColor = navigationColor;
    produce2VC.frameworkflag = layout_flag;
    produce2VC.default_url = DEFAULT_IMG_URL;
    produce2VC.framework_1_height_int = framework_1_height;
    produce2VC.framework_2_height_int = framework_2_height;
    produce2VC.framework_2_defaultX_int = framework_2_defaultX;
    
    
    CodeViewController *codeVC = [[CodeViewController alloc]init];
    codeVC.navigationTitle = @"二维码扫描";
    codeVC.navigationColor = navigationColor;
    
    
    id newslist = nil;
    switch (news_flag) {
        case 1:
            newslist = newslist2VC;
            break;
        case 2:
            newslist = newslist2VC;
            break;
    }
    
    id produce = nil;
    switch (produce_flag) {
        case 1:
            produce = produce1VC;
            break;
        case 2:
            produce = produce2VC;
            break;
    }
//    NSMutableArray *viewArray = nil;
//    viewArray = [[NSMutableArray alloc]initWithCapacity:2];
    NSMutableDictionary *menuAttributeArray = [[NSMutableDictionary alloc]init];
    
    if(layout_flag == 3 || layout_flag == 4 || layout_flag == 1)
    {
        for (SystemConfigDBItem *systemDBItem in systemSettingArray) {
            menuAttribute = [[MenuAttribute alloc]init];
            menuAttribute.cloumnName = systemDBItem.note;
            
            int index = [allFramArray  indexOfObject:systemDBItem.cloKey];
            switch (index) {
                case MoNews:
                {
                    if (layout_flag == 3) 
                        menuAttribute.cloumnImgName = NEWS_TRENDS_IMG;
                    else
                        menuAttribute.cloumnImgName = NEWS_TRENDS_PNG;
                    menuAttribute.cloumnVC = newslist;
                    newsList1VC.navigationTitle = menuAttribute.cloumnName;
                    
                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoProduct:
                {
                    if (layout_flag == 3)
                        menuAttribute.cloumnImgName = PRODUCT_DISPLAY_IMG;
                    else
                        menuAttribute.cloumnImgName = PRODUCT_DISPLAY_PNG;
                    menuAttribute.cloumnVC = produce;
                    produce1VC.navigationTitle  = menuAttribute.cloumnName;
                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoPicture:
                {
//                    if (layout_flag == 3)
//                        menuAttribute.cloumnImgName = PRODUCT_DISPLAY_IMG;
//                    else
//                        menuAttribute.cloumnImgName = PRODUCT_DISPLAY_PNG;
//                    menuAttribute.cloumnVC = produce;
//                    
//                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoMessage:
                {
                    if (layout_flag == 3)
                        menuAttribute.cloumnImgName = ONLINE_MESSAGE_IMG;
                    else
                        menuAttribute.cloumnImgName = ONLINE_MESSAGE_PNG;
                    menuAttribute.cloumnVC = feedBackObj;
                    feedBackObj.navigationTitle = menuAttribute.cloumnName;

                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoContact:
                {
                    if (layout_flag == 3)
                        menuAttribute.cloumnImgName = CONTACT_US_IMG;
                    else
                        menuAttribute.cloumnImgName = CONTACT_US_PNG;
                    menuAttribute.cloumnVC = aboutObj;
                   
                    getO.catid = systemDBItem.classN;//获取不同web的ID
                    NSString *aboutCategoryURL = [urlStr returnURL:52 Obj:getO];
                    menuAttribute.aboutURL = aboutCategoryURL;
                   
                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoProfile:
                {
                    if (layout_flag == 3)
                        menuAttribute.cloumnImgName = COMPANY_PROFILE_IMG;
                    else
                        menuAttribute.cloumnImgName = COMPANY_PROFILE_PNG;
                    menuAttribute.cloumnVC = aboutObj;
                    
                    getO.catid = systemDBItem.classN;
                    NSString *aboutCategoryURL = [urlStr returnURL:52 Obj:getO];
                    menuAttribute.aboutURL = aboutCategoryURL;
                   
                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                }
                    break;
                case MoQrcode:
                {
                    

                    //二维码扫描

                    if(layout_flag == 3)
                        menuAttribute.cloumnImgName = QRPICTURE_PNG;
                    else
                        menuAttribute.cloumnImgName = QRPICTURE_PNG;
                    menuAttribute.cloumnVC = codeVC;
                    [menuAttributeArray setObject:menuAttribute forKey:systemDBItem.sortNum];
                    
                    
                }
                    break;
                    
            }
        }
//        //联系我们
//        MenuAttribute *menuAttribute1 = [[MenuAttribute alloc]init];
//        menuAttribute1.cloumnName = @"联系我们";
//        menuAttribute1.cloumnVC = newslist;
//        if(layout_flag == 3)
//            menuAttribute1.cloumnImgName = COMPANY_PROFILE_IMG;
//        else
//            menuAttribute1.cloumnImgName = COMPANY_PROFILE_PNG;
//        
//        [menuAttributeArray setObject:menuAttribute1 forKey:[NSString stringWithFormat:@"%d",[systemSettingArray count]]];
        
       

//        [viewArray addObject:codeVC];
        
//        [menuCoverPicNameArr addObject:COMPANY_PROFILE_PNG]; 
        
//        viewArray=[[NSMutableArray alloc]initWithObjects:aboutObj,newslist,produce,feedBackObj,nil];
    }
    return menuAttributeArray;
}

@end
