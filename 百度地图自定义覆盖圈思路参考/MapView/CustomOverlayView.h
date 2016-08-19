//
//  CustomOverlayView.h
//  SHareihpme
//
//  Created by zy on 15-1-5.
//  Copyright (c) 2015年 FULLUSERNAME. All rights reserved.
//

#import <MapKit/MapKit.h>
@class CustomOverlayView;
@protocol CustomOverlayDelegate <NSObject>

-(void)addCircle:(CustomOverlayView *)overlayView;

@end


@interface CustomOverlayView : MKOverlayView

@property(nonatomic, readonly)MKMapRect circlebounds;
@property(nonatomic,assign)CGFloat mapRadius;
@property(nonatomic,assign)CGFloat circleframe;
@property(assign,nonatomic)id<CustomOverlayDelegate>delegate;

-(id)initWithOverlay:(MKCircle *)overlay withMapRaduis:(CGFloat)mapRadius;
-(void)setCircleRadius:(CGFloat)radius;

@end
