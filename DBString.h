//
//  DBString.h
//  MainFra
//
//  Created by Tang silence on 13-6-25.
//  Copyright (c) 2013年 Tang silence. All rights reserved.
//





//数据库名
#define DATABASE_NAME @"douwan.sqlite"
//系统设置
#define SYSTEMCONFIG_TABLENAME @"SystemConfig"
#define SYSTEMCONFIG_CTEATE_SQL @"create table if not exists SystemConfig (cloKey text primary key,cloValue text not null,sortNum Integer not null ,classN text,note text)"
//新闻类别
#define NEWS_CATEGORY_TABLENAME @"NewsCategory"
#define NEWS_CATEGORY_CREATE_SQL @"create table if not exists NewsCategory (catId Integer primary key,  catName text not null, modelId Integer not null)"
//新闻列表
#define NEWSLIST_TABLENAME @"NewsList"
#define NEWSLIST_CREATE_SQL @"create table if not exists NewsList (nId Integer primary key,catId Integer,title text,userName text,userId text,thumb text,description text)"
//新闻详细
#define NEWSDETAIL_TABLENAME @"NewsDetail"
#define NEWSDETAIL_CREATE_SQL @"create table if not exists NewsDetail (nId Integer primary key,title Integer,content text,catId Integer,dateline text,hits Integer)"
//新闻滚动
#define NEWSSCROLLLIST_TABLENAME @"NewsScrollList"
#define NEWSSCROLLLIST_CREATE_SQL @"create table if not exists NewsScrollList (nId Integer primary key,title text,thumb text)"



//产品类别
#define PRODUCE_CATEGORY_TABLENAME @"ProduceCategory"
#define PRODUCE_CATEGORY_CREATE_SQL @"create table if not exists ProduceCategory (catId Integer primary key,  catName text not null, modelId Integer not null,parentId Integer)"
//产品列表
#define PRODUCELIST_TABLENAME @"ProduceList"
#define PRODUCELIST_CREATE_SQL @"create table if not exists ProduceList (pId Integer primary key,catId Integer,title text,userName text,userId text,thumb text,description text,price text,xinghao text)"
//产品详细
#define PRODUCEDETAIL_TABLENAME @"ProduceDetail"
#define PRODUCEDETAIL_CREATE_SQL @"create table if not exists ProduceDetail (pId Integer primary key,title Integer,content text,catId Integer,dateline text,hits Integer,price text,xinghao text)"


//反馈列表
#define FEEDBACKLIST_TABLENAME @"FeedBackList"
#define FEEDBACKLIST_CREATE_SQL @"create table if not exists FeedBackList (nId Integer primary key,username text,tel text,content text,dateline text)"


