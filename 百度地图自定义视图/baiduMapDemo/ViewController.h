//
//  ViewController.h
//  baiduMapDemo
//
//  Created by 杨晓龙 on 13-3-29.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )  

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ViewController : UIViewController<BMKMapViewDelegate>{

   
    BMKMapView *mymapview ;

}

@end
