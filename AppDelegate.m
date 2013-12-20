//
//  AppDelegate.m
//  MPPlayer
//

#import "AppDelegate.h"
#import "MainFrameSetting.h"
#import "Constant.h"
#import "MainFramDragViewController.h"

#import "Reachability.h"

//获取网络数据相关
#import "JsonParser.h"
//url拼接相关
#import "UrlStr.h"
#import "GetObj.h"
//数据库相关
#import "RecordDao.h"
#import "SystemConfigDBItem.h"
@implementation AppDelegate


@synthesize window;
@synthesize tabbarArray = _tabbarArray;
@synthesize viewArray = _viewArray;
@synthesize nav = _nav;
@synthesize layout_flag;
@synthesize netWorkFlag;
@synthesize allFramArray;
@synthesize tabbarTitleArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create and initialize the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
	// Create test view controller
//    [self createViewController];
    flagSystem = 0;
    netWorkFlag = 0;
    //    id objects = {@"Layout",@"MoNews",@"MoProduct",@"MoPicture",@"MoMessage",@"MoContact"};
    //    allFramArray = [NSArray arrayWithObjects:objects count:6];
    allFramArray = [[NSArray alloc] initWithObjects:@"Layout",@"MoNews",@"MoProduct",@"MoPicture",@"MoMessage",@"MoContact", nil];
    //   allFramArray = @[@"Layout",@"MoNews",@"MoProduct",@"MoPicture",@"MoMessage",@"MoContact"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    //    reach.reachableBlock = ^(Reachability * reachability)
    //    {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    ////            blockLabel.text = @"Block Says Reachable";
    //        });
    //    };
    //
    //    reach.unreachableBlock = ^(Reachability * reachability)
    //    {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    ////            blockLabel.text = @"Block Says Unreachable";
    //        });
    //    };
    
    [reach startNotifier];
    
    [self initData];
    [self getSystemData];
    return YES;
}

#pragma mark systemData

- (void)getSystemData
{
//    listArray = [recordDB resultSet:SYSTEMCONFIG_TABLENAME Order:nil LimitCount:0];
//    if(flagSystem == 0)
//    {
//        GetObj *getO = [[GetObj alloc]init];
//        getO.app_id = appId;
//        NSString *newsCategoryURL = [urlStr returnURL:1 Obj:getO];
//        if(iPhone5)
//            imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default-568h@2x"]];
//        else
//            imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default.png"]];
//        imgV.frame = [UIScreen mainScreen].applicationFrame;
//        [self.window addSubview:imgV];
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//        [self.window makeKeyAndVisible];
//        [jsonParser parse:newsCategoryURL withDelegate:self onComplete:@selector(connectionSystemSuccess:) onErrorComplete:@selector(connectionError)];
//    }
//    else
//    {
//        [self systemSetting];
//    }
    
    NSString *jsonName = @"config.json";
    NSArray *Array = [jsonName componentsSeparatedByString:@"."];
    NSString *filename = [Array objectAtIndex:0];
    NSString *sufix = [Array objectAtIndex:1];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    id JsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//read json data
    
    NSDictionary *dic =  [JsonObject objectAtIndex:0];
    NSDictionary *styleDic = [dic objectForKey:@"style"];
    NSArray *keys = [styleDic allKeys];
    for (int i = 0;i<[keys count];i++) {
        NSArray *valueArray = [[styleDic objectForKey:[keys objectAtIndex:i]] componentsSeparatedByString:@","];
        NSArray *systemClosArray = [[NSArray alloc ]initWithObjects:[keys objectAtIndex:i],[valueArray objectAtIndex:0],[valueArray objectAtIndex:2],[valueArray objectAtIndex:3],[valueArray objectAtIndex:1], nil];
        SystemConfigDBItem *systemConfigDBItem = [[SystemConfigDBItem alloc]init];
        [systemConfigDBItem initData:systemClosArray];
        [listArray addObject:systemConfigDBItem];
    }
    
    [self systemSetting];
}


#pragma mark setting
- (void)systemSetting
{
    //1
    MainFrameSetting *mainFramSetting = [[MainFrameSetting alloc]init];
    mainFramSetting.systemSettingArray = listArray;
    [mainFramSetting openUI];
    //2
    MainFramDragViewController *mainFramDrag = [[MainFramDragViewController alloc]init];
    mainFramDrag.viewArray = _tabbarArray;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    switch (layout_flag) {
        case 1:
        {
            [_mTabBarController setViewControllers:[NSArray arrayWithObjects:[_tabbarArray objectAtIndex:0],[_tabbarArray objectAtIndex:1],[_tabbarArray objectAtIndex:2],[_tabbarArray objectAtIndex:3],[_tabbarArray objectAtIndex:4],nil]];
            _mTabBarController.tabbarTitleArray = self.tabbarTitleArray;
            self.window.rootViewController = _mTabBarController;
        }
            break;
        case 2:
            self.window.rootViewController = mainFramDrag;
            break;
        case 3:
        case 4:
            self.window.rootViewController = _nav;
            break;
    }
    [imgV setHidden:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark connection result

- (void)connectionSystemSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    
    NSArray *keys = [(NSDictionary *)[returnDic objectAtIndex:0] allKeys];
    [recordDB deleteAtIndex:SYSTEMCONFIG_TABLENAME CloValue:nil];
    for (int i = 0;i<[keys count];i++) {
        NSArray *valueArray = [[(NSDictionary *)[returnDic objectAtIndex:0] objectForKey:[keys objectAtIndex:i]] componentsSeparatedByString:@","];
        // NSArray *systemClosArray = @[[keys objectAtIndex:i],[valueArray objectAtIndex:0],[valueArray objectAtIndex:2],[valueArray objectAtIndex:3],[valueArray objectAtIndex:1]];
        
        NSArray *systemClosArray = [[NSArray alloc ]initWithObjects:[keys objectAtIndex:i],[valueArray objectAtIndex:0],[valueArray objectAtIndex:2],[valueArray objectAtIndex:3],[valueArray objectAtIndex:1], nil];
        
        [recordDB insertAtTable:SYSTEMCONFIG_TABLENAME Clos:systemClosArray];
    }
    flagSystem = 1;
    
    [self getSystemData];
}

- (void)connectionError
{
//    listArray = [recordDB resultSet:SYSTEMCONFIG_TABLENAME Order:nil LimitCount:0];
//    if([listArray count] > 0)
//        [self systemSetting];
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                       message:@"您未开启网络，请先设置网络"
//                                                      delegate:nil
//                                             cancelButtonTitle:@"确定"
//                                             otherButtonTitles:nil];
//        [alert show];
//    }
}

- (void)initData
{
    //数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //url
    urlStr = [[UrlStr alloc]init];
    //网络获取数据
    jsonParser = [[JsonParser alloc]init];
    listArray = [[NSMutableArray alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    _mTabBarController = [[ALTabBarController alloc]init];
    _mTabBarController.delegate = self;
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:[NSString stringWithFormat:@"%f",[[UIScreen mainScreen]bounds].size.width] forKey:@"com.medp.edp.window.width"];
    //    [defaults setObject:[NSString stringWithFormat:@"%f",[[UIScreen mainScreen]bounds].size.height] forKey:@"com.medp.edp.window.height"];
    
    //    _HUD = [[MBProgressHUD alloc] initWithView:self.window];
    //	[self.window addSubview:_HUD];
    //    _HUD.delegate = self;
}

#pragma mark UITabBarControllerDelegate method

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (_mTabBarController.selectedIndex) {
        case HOME:
        {
            NSLog(@"AA");
        }
            
            break;
        case ABOUT:
        {
            
        }
            break;
        case NewsE:
        {
            
        }
            
            break;
            
        case ProduceE:
        {
            
        }
            
            break;
            
        case MORE:
        {
            
        }
            
            break;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        if(netWorkFlag != 0)
            [self getSystemData];
        NSLog(@"网络连接正常");
        netWorkFlag = 1;
    }
    else
    {
        NSLog(@"网络连接失败");
        netWorkFlag = 2;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"网络已断开"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

//- (void)dealloc
//{
//    [window release];
//    [super dealloc];
//}

@end
