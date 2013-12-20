//
//  CodeViewController.m
//  MainFrame
//
//  Created by Tang silence on 13-7-11.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "CodeViewController.h"
//#import "ZBarSDK.h"
//#import "QRCodeGenerator.h"
#import "Constant.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

@synthesize navigationColor,navigationTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem.leftBarButtonItem setAction:@selector(back)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self button:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
//    [self button:0];
	// Do any additional setup after loading the view.
}

- (void)createView
{
    self.navigationController.navigationBar.tintColor = navigationColor;
    self.navigationItem.title = navigationTitle;

    
    scanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scanBtn.frame = CGRectMake(110, 150, 100, 45);
    [scanBtn setTitle:@"点击扫描" forState:UIControlStateNormal];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [scanBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    [scanBtn setHidden:NO];
    
    openBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    openBtn.frame = CGRectMake(125, 280, 70, 35);
    [openBtn setTitle:@"打开" forState:UIControlStateNormal];
    openBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [openBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    [openBtn setHidden:YES];
    
    msgLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 220, 30)];
    msgLab.text = @"";
    msgLab.font = [UIFont boldSystemFontOfSize:17.0];
    msgLab.textColor = [UIColor colorWithRed:180/255.0 green:33/255.0 blue:33/255.0 alpha:1];
    msgLab.numberOfLines = 0;
    msgLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:msgLab];
    
    
    contentLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 260, 50)];
    contentLab.text = @"";
    contentLab.font = [UIFont systemFontOfSize:17.0];
    contentLab.numberOfLines = 2;
//    contentLab.lineBreakMode = UILineBreakModeCharacterWrap;
    [self.view addSubview:contentLab];
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(85, 110, 150, 150)];
    [self.view addSubview:imageview];
}
- (void)button:(id)sender {
    /*扫描二维码部分：
     导入ZBarSDK文件并引入一下框架
     AVFoundation.framework
     CoreMedia.framework
     CoreVideo.framework
     QuartzCore.framework
     libiconv.dylib
     引入头文件#import “ZBarSDK.h” 即可使用
     当找到条形码时，会执行代理方法
     
     - (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
     
     最后读取并显示了条形码的图片和内容。*/
    
    //自定义阴影。
    UIView *overViewUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width,(Screen_height-250-44)/2)];
    UIView *overViewDown = [[UIView alloc] initWithFrame:CGRectMake(0, (Screen_height-250-44)/2+250, Screen_width,(Screen_height-250-44)/2)];
    UIView *overViewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, (Screen_height-250-44)/2, (Screen_width-250)/2,250)];
    UIView *overViewRight = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-250)/2 + 250, (Screen_height-250-44)/2, (Screen_width-250)/2,250)];
    
    overViewUp.backgroundColor = [UIColor blackColor];
    overViewUp.alpha = 0.8;
    overViewDown.backgroundColor = [UIColor blackColor];
    overViewDown.alpha = 0.8;
    overViewLeft.backgroundColor = [UIColor blackColor];
    overViewLeft.alpha = 0.8;
    overViewRight.backgroundColor = [UIColor blackColor];
    overViewRight.alpha = 0.8;
    
    //取景边框颜色
    UIView *overViewUpLine = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-250)/2, (Screen_height-250-44)/2, 250,2)];
    UIView *overViewDownLine = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-250)/2, (Screen_height-250-44)/2+250, 250,2)];
    UIView *overViewLeftLine = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-250)/2, (Screen_height-250-44)/2, 2,250)];
    UIView *overViewRightLine = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-250)/2 + 250-2, (Screen_height-250-44)/2, 2,250)];
    
    overViewUpLine.backgroundColor = [UIColor greenColor];
    overViewDownLine.backgroundColor = [UIColor greenColor];
    overViewLeftLine.backgroundColor = [UIColor greenColor];
    overViewRightLine.backgroundColor = [UIColor greenColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((Screen_width-250)/2, (Screen_height-250-44)/2+250, 250, 30)];
    tipLabel.text = @"请将二维码置于取景框内扫描";
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
//    ZBarReaderViewController *reader = [ZBarReaderViewController new];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    reader.showsZBarControls = YES;
////    reader.cameraOverlayView = overView;
//    reader.readerView.tracksSymbols = YES;
//    reader.readerView.trackingColor = [UIColor redColor];
//    reader.scanCrop = CGRectMake(0, 0, 0.5, 0.5);
//    [reader.readerView addSubview:overViewUp];
//    [reader.readerView addSubview:overViewDown];
//    [reader.readerView addSubview:overViewLeft];
//    [reader.readerView addSubview:overViewRight];
//    [reader.readerView addSubview:overViewUpLine];
//    [reader.readerView addSubview:overViewDownLine];
//    [reader.readerView addSubview:overViewLeftLine];
//    [reader.readerView addSubview:overViewRightLine];
//    [reader.readerView addSubview:tipLabel];
//    ZBarImageScanner *scanner = reader.scanner;
////
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    
//    [self presentModalViewController: reader
//                            animated: YES];
//    
//    [self.navigationController pushViewController:reader animated:YES];
//    [reader release];
}

- (void)button2:(id)sender {
    /*字符转二维码
     导入 libqrencode文件
     引入头文件#import "QRCodeGenerator.h" 即可使用
     */
//	imageview.image = [QRCodeGenerator qrImageForString:text.text imageSize:imageview.bounds.size.width];
    
}

- (void)Responder:(id)sender {
    //键盘释放
    [text resignFirstResponder];
    
}


//取消后直接回到首页
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        break;
//    
//    imageview.image =
//    [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    [reader dismissModalViewControllerAnimated: YES];
//    
//    //判断是否包含 头'http:'
//    NSString *regex = @"http+:[^\\s]*";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    
//    //判断是否包含 头'ssid:'
//    NSString *ssid = @"ssid+:[^\\s]*";;
//    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
//    
//    contentLab.text =  symbol.data ;
//    msgLab.text = @"监测到二维码信息" ;
////    [scanBtn setHidden:YES];
//    [scanBtn setFrame:CGRectMake(110, 330, 100, 45)];
//    [scanBtn setTitle:@"再次扫描" forState:UIControlStateNormal];
//    
//    if ([predicate evaluateWithObject:contentLab.text]) {
//        
////        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
////                                                        message:@"It will use the browser to this URL。"
////                                                       delegate:nil
////                                              cancelButtonTitle:@"Close"
////                                              otherButtonTitles:@"Ok", nil];
////        alert.delegate = self;
////        alert.tag=1;
////        [alert show];
//////        [alert release];
////        
//        [openBtn setHidden:NO];
//        
//    }
//    else if([ssidPre evaluateWithObject:contentLab.text]){
//         [openBtn setHidden:YES];
//        
//        NSArray *arr = [contentLab.text componentsSeparatedByString:@";"];
//        
//        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
//        
//        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
//        
//        
//        contentLab.text=
//        [NSString stringWithFormat:@"ssid: %@ \n password:%@",
//         [arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
//        
//        
////        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:contentLab.text
////                                                        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface"
////                                                       delegate:nil
////                                              cancelButtonTitle:@"Close"
////                                              otherButtonTitles:@"Ok", nil];
////        
////        
////        alert.delegate = self;
////        alert.tag=2;
////        [alert show];
////        [alert release];
//        
//        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
//        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
//        pasteboard.string = [arrInfoFoot objectAtIndex:1];
//    }
//    else
//        [openBtn setHidden:YES];
//}
- (void)back
{
    [self createView];
}

- (void)openURL
{
    NSString *urlStr = contentLab.text;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
