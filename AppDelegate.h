//
//  AppDelegate.h
//  MPPlayer
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ALTabBarController.h"
@class RecordDao;
@class UrlStr;
@class JsonParser;

enum {
    HOME = 0,
    ABOUT = 1,
    NewsE = 2,
    ProduceE = 3,
    MORE = 4
};

@interface AppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate,UIAlertViewDelegate> {

    UIWindow *window;
    ALTabBarController *_mTabBarController;           //导航
    
    UrlStr *urlStr;
    
    JsonParser *jsonParser;
    RecordDao *recordDB;
    NSMutableArray *listArray;
//    NSDictionary *listDic;
    int flagSystem; //0 读网络 1 不读取网络
    UIImageView *imgV;
}

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic, retain) NSArray *allFramArray;
@property (nonatomic,retain)NSMutableArray *tabbarArray;
@property (nonatomic,retain)NSMutableArray *viewArray;
@property (nonatomic) int netWorkFlag;  //1 代表正常连接   2代表连接失败

@property (nonatomic , retain) UINavigationController *nav;
@property (nonatomic) int layout_flag;

@property (nonatomic, retain) NSArray *tabbarTitleArray;

@end
