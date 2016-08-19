//
//  CustomAnnotationView.h
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "BMKPinAnnotationView.h"

@interface CustomAnnotationView : BMKAnnotationView
{
    UIImageView *_hotelImageView;
    UILabel *_hotelName;
    UILabel *_typeName;
}
@end
