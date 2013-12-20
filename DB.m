//
//  DB.m
//  MainFra
//
//  Created by Tang silence on 13-6-25.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "DB.h"
#import "DBString.h"

@implementation DB


- (BOOL)initDatabase:(NSString *)databaseName
{
	BOOL success;
	NSError *error;
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
	
	success = [fm fileExistsAtPath:writableDBPath];
	
	if(!success){
		NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:databaseName];
		success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
		if(!success){
			NSLog(@"error: %@", [error localizedDescription]);
		}
		success = YES;
	}
	if(success){
		db = [FMDatabase databaseWithPath:writableDBPath];
		if ([db open]) {
			[db setShouldCacheStatements:YES];
		}else{
			NSLog(@"Failed to open database.");
			success = NO;
		}
        [self createTable];
	}
	return success;
}
-(void)createTable
{
    [db executeUpdate:SYSTEMCONFIG_CTEATE_SQL];
    [db executeUpdate:NEWS_CATEGORY_CREATE_SQL];
    [db executeUpdate:NEWSLIST_CREATE_SQL];
    [db executeUpdate:NEWSDETAIL_CREATE_SQL];
    [db executeUpdate:PRODUCE_CATEGORY_CREATE_SQL];
    [db executeUpdate:PRODUCELIST_CREATE_SQL];
    [db executeUpdate:PRODUCEDETAIL_CREATE_SQL];
    [db executeUpdate:NEWSSCROLLLIST_CREATE_SQL];
    [db executeUpdate:FEEDBACKLIST_CREATE_SQL];
}
- (void)closeDatabase
{
	[db close];
}
- (FMDatabase *)getDatabase:(NSString *)databaseName
{
	if ([self initDatabase:databaseName]){
		return db;
	}
	return NULL;
}

//
//- (void)dealloc
//{
//	[self closeDatabase];
//}
@end
