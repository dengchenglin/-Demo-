//
//  header.h
//  HeheyuanDemo
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 jiangjun. All rights reserved.
//

#import "JJMemoryManger.h"
#import "JJDevice.h"
#import "AffUIToolBar.h"
#import "LoginModel.h"
#import "SynthesizeSingleton.h"
#import "HHYNetworkEngine+Detail.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "PassWordModel.h"

#define kNeedLogin @"com.hhy.needLogin"

//比较两天的结果
typedef enum{
    UIDayModelBefore = -1,
    UIDayModelEqual,
    UIDayModelAfter
}UIDayCompareRet;
//测试城市列表URL
#define CITY_URL @"http://123.57.36.238:8080/cloud/cities/query"
#define REGINE_URL @"http://123.57.36.238:8080/cloud/user/register"
#define LOGIN_URL @"http://123.57.36.238:8080/cloud/user/login"
#define QUERY_PERSONURL @"http://123.57.36.238:8080/cloud/user/queryOneUser"
#define UPDATE_PERSONINFO @"http://123.57.36.238:8080/cloud/user/update/%@"
#define ALL_CYCJR_URL @"http://123.57.36.238:8080/cloud/cycjr/query"
#define ADD_CYCJR_URL @"http://123.57.36.238:8080/cloud/cycjr/addPassenger/%@"
#define EDIT_CYCJR_URL @"http://123.57.36.238:8080/cloud/cycjr/update/%@"
#define DELETE_CJR_URL @"http://123.57.36.238:8080/cloud/cycjr/remove/%@"
#define ASK_AIRTICKET @"%@/%@/%@/%@/%@"
#define GET_ORDER_URL @"http://123.57.36.238:8080/cloud/order/saveOrder/%@"
#define BG_COLRO [JJDevice colorWithR:240.0 G:240.0 B:240.0 A:1.0]
