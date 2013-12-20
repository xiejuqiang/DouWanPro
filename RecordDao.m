//
//  RecordDao.m
//  MainFra
//
//  Created by Tang silence on 13-6-25.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//

#import "RecordDao.h"
#import "DB.h"
#import "SystemConfigDBItem.h"
#import "NewsListDBItem.h"
#import "NewsCategoryDBItem.h"
#import "NewsDetailDBItem.h"
#import "NewsScrollDBItem.h"

#import "ProduceCategoryDBItem.h"
#import "ProduceListDBItem.h"
#import "ProduceDetailDBItem.h"
#import "FeedBackListDBItem.h"

@implementation RecordDao

-(void)initArray
{
    //对应自己数据库字段名 参考DBString.h
    
    systemConfigArray = [[NSArray alloc] initWithObjects:@"cloKey",@"cloValue",@"sortNum",@"classN",@"note", nil];
    newsCategoryArray = [[NSArray alloc] initWithObjects:@"catID",@"catName",@"modelID", nil];
    newsListArray = [[NSArray alloc] initWithObjects:@"nId",@"catId",@"title",@"userName",@"userId",@"thumb",@"description", nil];
    newsDetailArray = [[NSArray alloc] initWithObjects:@"nId",@"title",@"content",@"catId",@"dateline",@"hits", nil];
    newsScrollListArray = [[NSArray alloc] initWithObjects:@"nId",@"title",@"thumb", nil];
    produceCategoryArray = [[NSArray alloc] initWithObjects:@"catID",@"catName",@"modelID",@"parentId", nil];
    produceListArray = [[NSArray alloc] initWithObjects:@"pId",@"catId",@"title",@"userName",@"userId",@"thumb",@"description",@"price",@"xinghao", nil];
    produceDetailArray = [[NSArray alloc] initWithObjects:@"pId",@"title",@"content",@"catid",@"dateline",@"hits",@"price",@"xinghao", nil];
    feedBackListArray = [[NSArray alloc] initWithObjects:@"nId",@"username",@"tel",@"content",@"dateline", nil];
   // systemConfigArray = @[@"cloKey",@"cloValue",@"sortNum",@"classN",@"note"];   //5
   // newsCategoryArray = @[@"catID",@"catName",@"modelID"];//3
   // newsListArray = @[@"nId",@"catId",@"title",@"userName",@"userId",@"thumb",@"description"]; //7
  //  newsDetailArray = @[@"nId",@"title",@"content",@"catId",@"dateline",@"hits"]; //6
    
  //  newsScrollListArray = @[@"nId",@"catId",@"title",@"userName",@"userId",@"thumb",@"description",@"dateline",@"hits"];
    
    
  //  produceCategoryArray = @[@"catID",@"catName",@"modelID",@"parentId"];//3
 //   produceListArray = @[@"pId",@"catId",@"title",@"userName",@"userId",@"thumb",@"description",@"price",@"xinghao"]; //10
 //   produceDetailArray = @[@"pId",@"title",@"content",@"catid",@"dateline",@"hits",@"price",@"xinghao"]; //8
    
  //  feedBackListArray = @[@"nId",@"username",@"tel",@"content",@"dateline"];
}
-(void)createDB:(NSString *)databaseName
{
    db = [[[DB alloc] getDatabase:databaseName] retain];
    [self initArray];
}

- (BOOL)insertAtTable:(NSString *)tablename Clos:(NSArray*)clos
{
    BOOL success = YES;
    NSArray *keys = nil;
    if([tablename isEqualToString:SYSTEMCONFIG_TABLENAME] == YES)
    {
        keys = systemConfigArray;
    }
    else if([tablename isEqualToString:NEWSLIST_TABLENAME] == YES)
    {
        keys = newsListArray;
    }
    else if([tablename isEqualToString:NEWS_CATEGORY_TABLENAME] == YES)
    {
        keys = newsCategoryArray;
    }
    else if([tablename isEqualToString:NEWSDETAIL_TABLENAME] == YES)
    {
        keys = newsDetailArray;
    }
    else if([tablename isEqualToString:PRODUCE_CATEGORY_TABLENAME] == YES)
    {
        keys = produceCategoryArray;
    }
    else if([tablename isEqualToString:PRODUCELIST_TABLENAME] == YES)
    {
        keys = produceListArray;
    }
    else if([tablename isEqualToString:PRODUCEDETAIL_TABLENAME] == YES)
    {
        keys = produceDetailArray;
    }
    else if([tablename isEqualToString:NEWSSCROLLLIST_TABLENAME] == YES)
    {
        keys = newsScrollListArray;
    }
    else if([tablename isEqualToString:FEEDBACKLIST_TABLENAME] == YES)
    {
        keys = feedBackListArray;
    }
    
    int flag = 0;
    NSString *sqlStr = nil;
    NSString *sqlStr1 = [NSString stringWithFormat:@"INSERT INTO %@ (",tablename];
    NSString *sqlStr2 = @") VALUES (";
    for (NSString *key in keys) {
        flag++;
        if(flag == [keys count])
        {
            sqlStr1 = [NSString stringWithFormat:@"%@ %@",sqlStr1,key];
            sqlStr2 = [NSString stringWithFormat:@"%@ ?",sqlStr2];
        }
        else
        {
            sqlStr1 = [NSString stringWithFormat:@"%@ %@,",sqlStr1,key];
            sqlStr2 = [NSString stringWithFormat:@"%@ ?,",sqlStr2];
        }
    }
    sqlStr2 = [NSString stringWithFormat:@"%@)",sqlStr2];
    
    sqlStr = [NSString stringWithFormat:@"%@%@",sqlStr1,sqlStr2];
    
    [db executeUpdate:sqlStr withArgumentsInArray:clos];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
	}
    return success;
}
- (BOOL)deleteAtIndex:(NSString *)tableName CloValue:(NSString *)cloValue
{
    BOOL success = YES;
    NSArray *keys = nil;
    NSString *sqlStr;
    if([tableName isEqualToString:SYSTEMCONFIG_TABLENAME] == YES)
    {
        keys = systemConfigArray;
    }
    else if([tableName isEqualToString:NEWSLIST_TABLENAME] == YES)
    {
        keys = newsListArray;
    }

    if(cloValue == nil)
    {
        sqlStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE 1==1",tableName];
    }
    else
    {
        sqlStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,[keys objectAtIndex:0]];
    }
    
    [db executeUpdate:sqlStr,cloValue];
	if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
	}
	return success;
}
- (BOOL)updateAtTable:(NSString *)tablename Clos:(NSArray *)clos
{
    BOOL success = YES;
    NSArray *keys = nil;
    if([tablename isEqualToString:SYSTEMCONFIG_TABLENAME] == YES)
    {
        keys = systemConfigArray;
        
        int flag = 0;
        NSString *sqlStr = nil;
        NSString *sqlStr1 = [NSString stringWithFormat:@"UPDATE %@ SET",tablename];
        NSString *sqlStr2 = [NSString stringWithFormat:@"WHERE %@=? AND %@=?",[keys objectAtIndex:0],[keys objectAtIndex:1]];
        for (NSString *key in keys) {
            flag++;
            if(flag == 1)
            {
                continue;
            }
            else if(flag == [keys count])
            {
                sqlStr1 = [NSString stringWithFormat:@"%@ %@=?",sqlStr1,key];
            }
            else
            {
                sqlStr1 = [NSString stringWithFormat:@"%@ %@=?,",sqlStr1,key];
            }
        }
        sqlStr = [NSString stringWithFormat:@"%@ %@",sqlStr1,sqlStr2];
        
        [db executeUpdate:sqlStr withArgumentsInArray:clos];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
        }
    }
    return success;
}
- (NSMutableArray *)resultSetWhere:(NSString *)tablename Where:(NSString *)where
{
    FMResultSet *rs = nil;
    rs=[db executeQuery:where];
    return [self rsToItem:rs TableName:tablename];
    
}
- (NSMutableArray *)resultSet:(NSString *)tableName Order:(NSString *)order LimitCount:(int)limitCount
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    FMResultSet *rs = nil;
    NSArray *returnArray = nil;
    if(limitCount != 0 && order != nil)
    {
        rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ DESC LIMIT %d",tableName,order,limitCount]];
    }
    else if(order == nil && limitCount == 0)
    {
        rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
    }
    else if(order != nil)
    {
        rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@",tableName,order]];
    }
    else if(limitCount != 0)
    {
        rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT %d",tableName,limitCount]];
    }
    
    if([tableName isEqualToString:SYSTEMCONFIG_TABLENAME]==YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],nil];
            SystemConfigDBItem *systemConfigDBItem = [[SystemConfigDBItem alloc]init];
            [systemConfigDBItem initData:returnArray];
            [result addObject:systemConfigDBItem];
        }
    }
    else if([tableName isEqualToString:NEWS_CATEGORY_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],nil];
            NewsCategoryDBItem *categoryDBItem = [[NewsCategoryDBItem alloc]init];
            [categoryDBItem initData:returnArray];
            [result addObject:categoryDBItem];
        }
    }
    else if([tableName isEqualToString:NEWSLIST_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],[rs stringForColumn:[rs columnNameForIndex:5]],[rs stringForColumn:[rs columnNameForIndex:6]],nil];
            NewsListDBItem *newsListDBItem = [[NewsListDBItem alloc]init];
            [newsListDBItem initData:returnArray];
            [result addObject:newsListDBItem];
        }
    }
    else if([tableName isEqualToString:NEWSDETAIL_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],[rs stringForColumn:[rs columnNameForIndex:5]],nil];
            NewsDetailDBItem *newsDetailDBItem = [[NewsDetailDBItem alloc]init];
            [newsDetailDBItem initData:returnArray];
            [result addObject:newsDetailDBItem];
        }
    }
    else if([tableName isEqualToString:PRODUCE_CATEGORY_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],nil];
            ProduceCategoryDBItem *categoryDBItem = [[ProduceCategoryDBItem alloc]init];
            [categoryDBItem initData:returnArray];
            [result addObject:categoryDBItem];
        }
    }
    else if([tableName isEqualToString:PRODUCELIST_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],[rs stringForColumn:[rs columnNameForIndex:5]],[rs stringForColumn:[rs columnNameForIndex:6]],[rs stringForColumn:[rs columnNameForIndex:7]],[rs stringForColumn:[rs columnNameForIndex:8]],nil];
            ProduceListDBItem *produceListDBItem = [[ProduceListDBItem alloc]init];
            [produceListDBItem initData:returnArray];
            [result addObject:produceListDBItem];
        }
    }
    else if([tableName isEqualToString:PRODUCEDETAIL_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],[rs stringForColumn:[rs columnNameForIndex:5]],[rs stringForColumn:[rs columnNameForIndex:6]],[rs stringForColumn:[rs columnNameForIndex:7]],nil];
            ProduceDetailDBItem *produceDetailDBItem = [[ProduceDetailDBItem alloc]init];
            [produceDetailDBItem initData:returnArray];
            [result addObject:produceDetailDBItem];
        }
    }
    else if([tableName isEqualToString:NEWSSCROLLLIST_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],nil];
            NewsScrollDBItem *newsScrollDBItem = [[NewsScrollDBItem alloc]init];
            [newsScrollDBItem initData:returnArray];
            [result addObject:newsScrollDBItem];
        }
    }
    else if([tableName isEqualToString:FEEDBACKLIST_TABLENAME] == YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],[rs stringForColumn:[rs columnNameForIndex:4]],nil];
            FeedBackListDBItem *feedBackListDBItem = [[FeedBackListDBItem alloc]init];
            [feedBackListDBItem initData:returnArray];
            [result addObject:feedBackListDBItem];
        }
    }
    return result;
}

- (NSMutableArray *)rsToItem:(FMResultSet *)rs TableName:(NSString *)tableName
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *returnArray = nil;
    if([tableName isEqualToString:PRODUCE_CATEGORY_TABLENAME]==YES)
    {
        while ([rs next])
        {
            returnArray = [[NSArray alloc]initWithObjects:[rs stringForColumn:[rs columnNameForIndex:0]],[rs stringForColumn:[rs columnNameForIndex:1]],[rs stringForColumn:[rs columnNameForIndex:2]],[rs stringForColumn:[rs columnNameForIndex:3]],nil];
            ProduceCategoryDBItem *categoryDBItem = [[ProduceCategoryDBItem alloc]init];
            [categoryDBItem initData:returnArray];
            [result addObject:categoryDBItem];
        }
    }
    
    return result;
}

@end
