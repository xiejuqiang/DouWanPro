//
//  FeedBack.m
//  FeedBack
//
//  Created by Tang silence on 13-6-20.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "FeedBack.h"
#import "Constant.h"
#import <QuartzCore/QuartzCore.h>
#import "UrlStr.h"
#import "GetObj.h"
#import "PostThread.h"
#import "JsonParser.h"
#import "RecordDao.h"
#import "GetObj.h"
#import "FeedBackListViewController.h"
#import "CustomTextField.h"


@implementation FeedBack
@synthesize postUrl = _postUrl;
@synthesize frameworkflag = _frameworkflag;
@synthesize navigationColor = _navigationColor;
@synthesize navigationTitle = _navigationTitle;
@synthesize framework_1_height_int,framework_2_height_int,framework_2_defaultX_int;
@synthesize returnString;

@synthesize netWorkFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        //左边 返回按钮
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0.0, 0.0, 30.0, 20.0);
//        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateSelected];
//        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *temporaryBarButtonItemBack = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        temporaryBarButtonItemBack.style = UIBarButtonItemStylePlain;
//        self.navigationItem.leftBarButtonItem=temporaryBarButtonItemBack;
        
    }
    return self;
}
-(void)initData
{
    //得出屏幕高度
    CGSize result = [[UIScreen mainScreen] bounds].size;
    windowHeight = result.height;
    urlStr = [[UrlStr alloc] init];
    //数据库
    recordDB = [[RecordDao alloc]init];
    [recordDB createDB:DATABASE_NAME];
    //网络获取数据
    jsonParser = [[JsonParser alloc]init];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //UIKeyboardWillShowNotification键盘出现
    [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //UIKeyboardWillHideNotification 键盘隐藏
    [defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark getData
- (void)getFeedBackListData
{
    listArray = [recordDB resultSet:FEEDBACKLIST_TABLENAME Order:nil LimitCount:0];
    if([listArray count] == 0)
    {
        GetObj *getO = [[GetObj alloc]init];
        getO.app_id = appId;
        getO.page = @"1";
        NSString *feedBackListURL = [urlStr returnURL:51 Obj:getO];
        
        
        [jsonParser parse:feedBackListURL withDelegate:self onComplete:@selector(connectionNewsScrollSuccess:) onErrorComplete:@selector(connectionError)];
    }
    else
    {
        FeedBackListViewController *feedBackListVC = [[FeedBackListViewController alloc] init];
        feedBackListVC.returnDataArray = listArray;
        [self.navigationController pushViewController:feedBackListVC animated:YES];
       
    }
}

- (void)connectionNewsScrollSuccess:(JsonParser *)jsonP
{
    NSArray *returnDic = [jsonP getItems];
    NSLog(@"%@",returnDic);
    for (int i = 0;i<[returnDic count];i++) {
        //NSArray *feedBackListArray = @[[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"username"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"tel"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"content"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"]];
	id objects[] = {[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"id"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"username"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"tel"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"content"],[(NSDictionary *)[returnDic objectAtIndex:i] objectForKey:@"dateline"]};
        NSArray *feedBackListArray = [NSArray arrayWithObjects:objects count:5];
        [recordDB insertAtTable:FEEDBACKLIST_TABLENAME Clos:feedBackListArray];
    }
    
    [self getFeedBackListData];
}

- (void)setNavigationAttributes
{
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAV_BACKGROUND_IMG] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.topItem.title = NAVBAR_TITLE_STR;
    //    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:5.0 forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorWithRed:255 green:255 blue:255 alpha:1],UITextAttributeTextColor,
                                    [UIFont systemFontOfSize:18],UITextAttributeFont,
                                    [UIColor grayColor],UITextAttributeTextShadowColor,
                                    [NSValue valueWithCGSize:CGSizeMake(1, 1)],UITextAttributeTextShadowOffset,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationItem.title = @"在线留言";
}



- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
	NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
//        _myTextV.frame = CGRectMake(10, 10, 300, windowHeight -  200 -height);
//        postBtn.frame = CGRectMake(270, windowHeight -100-height, 40, 30);
        _myTextV.frame = CGRectMake(10, 90, 300, windowHeight -  160 -height);
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.5 animations:^{
//        _myTextV.frame = CGRectMake(10, 10, 300, windowHeight - 200);
//        postBtn.frame = CGRectMake(270, windowHeight -100, 40, 30);
        _myTextV.frame = CGRectMake(10, 90,300, windowHeight -  270);
    }];
}

- (void)setPersonInfo
{
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.text = @"姓  名:";
    userNameLabel.font = [UIFont systemFontOfSize:18];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.frame = CGRectMake(10, 10, 100, 30);
    userNameLabel.textColor = [UIColor grayColor];
    userNameLabel.backgroundColor = [UIColor clearColor];
    
    UILabel *telNumberLabel = [[UILabel alloc] init];
    telNumberLabel.text = @"电  话:";
    telNumberLabel.font = [UIFont systemFontOfSize:18];
    telNumberLabel.textAlignment = NSTextAlignmentLeft;
    telNumberLabel.frame = CGRectMake(10, 50, 100, 30);
    telNumberLabel.textColor = [UIColor grayColor];
    telNumberLabel.backgroundColor = [UIColor clearColor];
    
    _userName = [[CustomTextField alloc] init];
    _userName.placeholder = @"输入你的姓名";
    _userName.delegate = self;
    _userName.frame = CGRectMake(80, 10, 230, 30);
    _userName.backgroundColor = [UIColor whiteColor];
    _userName.textAlignment = NSTextAlignmentLeft;
    _userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _telNumber = [[CustomTextField alloc] init];
    _telNumber.placeholder = @"输入电话号码";
    _telNumber.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _telNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _telNumber.delegate = self;
    _telNumber.frame = CGRectMake(80, 50, 230, 30);
    _telNumber.backgroundColor = [UIColor whiteColor];
    _telNumber.textAlignment = NSTextAlignmentLeft;
    _telNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    [self setViewLayer:_userName];
    [self setViewLayer:_telNumber];
    
    [self.view addSubview:userNameLabel];
    [self.view addSubview:telNumberLabel];
    [self.view addSubview:_userName];
    [self.view addSubview:_telNumber];
}
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}
- (void)createPostButton
{
   
    
//        postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [self.view addSubview:postBtn];
//        [postBtn setTitle:@"提交" forState:UIControlStateNormal];
//        [postBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        postBtn.frame = CGRectMake(270, windowHeight -100, 40, 30);
//        [postBtn addTarget:self action:@selector(postClick) forControlEvents:UIControlEventTouchUpInside];

    postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:postBtn];
    [postBtn setTitle:@"提交" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iPhone5)
    {
        postBtn.frame = CGRectMake(10, 400, 300, 40);
    }
    else
    {
        postBtn.frame = CGRectMake(10, 320, 300, 40);
    }
    
    [postBtn addTarget:self action:@selector(postClick) forControlEvents:UIControlEventTouchUpInside];
    [self setViewLayer:postBtn];
    
//    postBtn.backgroundColor = [UIColor blueColor];
}

//post
- (void)postClick
{
    HUD = [[MBProgressHUD alloc ]initWithView:self.view];
    [self.view addSubview:HUD];
    if ([self judgeStr]) {
        if ([self isMobileNumber:_telNumber.text]==NO) {
            HUD.labelText = @"请输入正确的手机号";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            return;
        }
        GetObj *getObj = [[GetObj alloc] init];
        getObj.app_id = appId;
        NSString *postUrlStr = [urlStr returnURL:50 Obj:getObj];
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
        PostThread *postThread = [[PostThread alloc]init];
        postThread.postUrl = postUrlStr;
        postThread.postViewController = self;
        postThread.username = _userName.text;
        postThread.tel = _telNumber.text;
        postThread.content = _myTextV.text;
        
        [operationQueue addOperation:postThread];
    }
    else
    {
        [HUD hide:YES afterDelay:1];
    }

}

- (BOOL)judgeStr
{
    if ((_userName.text == nil) || (_telNumber.text == nil) || (_myTextV.text == nil) ||
        [_userName.text isEqualToString:@""] || [_telNumber.text isEqualToString:@""] || [_myTextV.text isEqualToString:@""])
    {
        if (_userName.text == nil || [_userName.text isEqualToString:@""]) {
            HUD.labelText = @"姓名不能为空";
        }
        else if(_telNumber.text == nil || [_telNumber.text isEqualToString:@""])
        {
            HUD.labelText = @"电话不能为空";
        }
        else if (_myTextV.text == nil || [_myTextV.text isEqualToString:@""])
        {
            HUD.labelText = @"反馈内容不能为空";
        }
        [HUD show:YES];
            return NO;
    }
    return YES;
}

- (void)setViewLayer:(id)obj
{
    //实现原角
	[[obj layer] setBorderWidth:1.2];//画线的宽度
	[[obj layer] setBorderColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1].CGColor];//颜色
//	[[obj layer] setCornerRadius:7];//圆角
    [obj setBackgroundColor:[UIColor whiteColor]];
    [[obj layer] setMasksToBounds:YES];

}

-(void)createView
{
    _myTextV = [[UITextView alloc]init];
    _myTextV.text = TEXTVIEW_DEFAULT_TEXT;
    _myTextV.delegate = self;
    _myTextV.font = [UIFont systemFontOfSize:18];
    
    
//    //实现原角
//	[[_myTextV layer] setBorderWidth:1.2];//画线的宽度
//	[[_myTextV layer] setBorderColor:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:1].CGColor];//颜色
//	[[_myTextV layer] setCornerRadius:7];//圆角
//	_myTextV.backgroundColor=[UIColor whiteColor];
//	//[v.layer setCornerRadius:8.0];
//	[_myTextV.layer setMasksToBounds:YES];
    
    [self setViewLayer:_myTextV];
    
    switch (self.frameworkflag) {
        case 1:
        {
            //设置navigation样式
            self.navigationController.navigationBar.tintColor = _navigationColor;
            self.navigationItem.title = _navigationTitle;
            //设置本身view
            self.view.frame = CGRectMake(0, 0, 320, windowHeight - framework_1_height_int);
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:POST style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightButton)];
            [self.navigationItem setRightBarButtonItem:rightButton];
            [self setPersonInfo];
            _myTextV.frame = CGRectMake(10, 90, 300, windowHeight -  270);
            [self createPostButton];
        }
            break;
        case 2:
        {
            self.view.frame = CGRectMake(0, framework_2_defaultX_int, 320, windowHeight - framework_2_height_int);
        }
            break;
        case 3:
        case 4:
            [self setNavigationAttributes];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:POST style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightButton)];
            [self.navigationItem setRightBarButtonItem:rightButton];
            [self setPersonInfo];
            _myTextV.frame = CGRectMake(10, 90, 300, windowHeight -  200);
            [self createPostButton];
            
            break;
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    if (self.frameworkflag == 1 || self.frameworkflag == 2) {
//        _myTextV.frame = CGRectMake(10, 10, 300, windowHeight -  200);
//    }
    
    [self.view addSubview:_myTextV];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createView];
    
}

//此方法用于textfield 失去焦点时触发 触发后隐藏软键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_myTextV resignFirstResponder];
    [_userName resignFirstResponder];
    [_telNumber resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
	/**
	 * 手机号码
	 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
	 * 联通：130,131,132,152,155,156,185,186
	 * 电信：133,1349,153,180,189
	 */
    //	NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
	/**
	 10         * 中国移动：China Mobile
	 11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
	 12         */
    //	NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
	/**
	 15         * 中国联通：China Unicom
	 16         * 130,131,132,152,155,156,185,186
	 17         */
    //	NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
	/**
	 20         * 中国电信：China Telecom
	 21         * 133,1349,153,180,189
	 22         */
    //	NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
	/**
	 25         * 大陆地区固话及小灵通
	 26         * 区号：010,020,021,022,023,024,025,027,028,029
	 27         * 号码：七位或八位
	 28         */
	// NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString *isNumber = @"09[0-9]{8,}";
    NSString *isNumber2 = @"1[0-9]{10,}";
    //
    //	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //	NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //	NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //	NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextIsNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isNumber];
    NSPredicate *regextIsNumber2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isNumber2];
	
    //    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
    //		|| ([regextestcm evaluateWithObject:mobileNum] == YES)
    //		|| ([regextestct evaluateWithObject:mobileNum] == YES)
    //		|| ([regextestcu evaluateWithObject:mobileNum] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    if([regextIsNumber evaluateWithObject:mobileNum] == YES || [regextIsNumber2 evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
        return NO;
}

//get list
- (void)clickRightButton
{
    NSLog(@"反馈");
    [self getFeedBackListData];
    
    
}

- (void)postResult
{
    NSError *error;
  _jsonArray =  [NSJSONSerialization JSONObjectWithData:[returnString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    NSArray *arr=[[NSArray alloc] initWithArray:(NSArray *)_jsonArray];
    NSLog(@"%@",arr);
    HUD.labelText = @"上传成功";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
    //上传成功后重新读服务器数据来更新本地数据库
    GetObj *getO = [[GetObj alloc]init];
    getO.app_id = appId;
    getO.page = @"1";
    NSString *feedBackListURL = [urlStr returnURL:51 Obj:getO];
    [jsonParser parse:feedBackListURL withDelegate:self onComplete:@selector(connectionNewsScrollSuccess:) onErrorComplete:@selector(connectionError)];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	//获取光标问题
	[textView becomeFirstResponder];
	
	return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_myTextV.text isEqualToString:TEXTVIEW_DEFAULT_TEXT]) 
		_myTextV.text=@"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
