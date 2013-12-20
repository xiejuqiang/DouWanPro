//
//  VersionThread.m
//  speech
//
//  Created by Tang silence on 13-3-14.
//
//

#import "VersionThread.h"
#import "Constant.h"
@implementation VersionThread
@synthesize functionF = _functionF;
- (void)main{
    NSString *URL = APP_URL;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if(recervedData !=nil)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *infoArray = [dic objectForKey:@"results"];
        NSLog(@"dic %@",dic);
        ((UrlStr *)_functionF).infoArray = infoArray;
        [(UrlStr *)_functionF performSelectorOnMainThread:@selector(versionCompare) withObject:nil waitUntilDone:NO];
    }
}
-(void)dealloc
{
    self.functionF = nil;
    [super dealloc];
}
@end
