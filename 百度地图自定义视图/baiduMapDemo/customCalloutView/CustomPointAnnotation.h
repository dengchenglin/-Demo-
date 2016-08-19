//
//  CustomPointAnnotation.h
//  baiduMapDemo
//
//  Created by 杨晓龙 on 13-4-12.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface CustomPointAnnotation : BMKPointAnnotation


@property(retain,nonatomic) NSDictionary *pointCalloutInfo;//标注点传递的callout吹出框显示的信息
@end
