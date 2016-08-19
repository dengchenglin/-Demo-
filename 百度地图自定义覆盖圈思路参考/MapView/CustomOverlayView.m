//
//  CustomOverlayView.m
//  SHareihpme
//
//  Created by zy on 15-1-5.
//  Copyright (c) 2015年 FULLUSERNAME. All rights reserved.
//

#import "CustomOverlayView.h"
#import "CustomCircleView.h"

@implementation CustomOverlayView
{
    CustomCircleView *customCircleView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setCircleRadius:(CGFloat)radius
{
   
    _mapRadius = _mapRadius + radius;
    [self setNeedsDisplayInRect:[self bounds]];
}


-(id)initWithOverlay:(MKCircle *)circle withMapRaduis:(CGFloat)mapRadius
{
    if (self = [super initWithOverlay:(MKCircle *)circle])
    {
     
        self.mapRadius =mapRadius;
        [self commonInit];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)commonInit
{
    customCircleView = [[CustomCircleView alloc]init];
    [self addSubview:customCircleView];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    MKMapPoint mpoint =  MKMapPointForCoordinate([[self overlay] coordinate]);
    _circlebounds = MKMapRectMake(mpoint.x - _mapRadius, mpoint.y - _mapRadius, _mapRadius * 2, _mapRadius * 2);
    CGRect overlayRect = [self rectForMapRect:_circlebounds];
    
    if(customCircleView)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            customCircleView.frame = overlayRect;
            [customCircleView setNeedsDisplay];
            if(self.delegate && [self.delegate respondsToSelector:@selector(addCircle:)])
            {
                [self.delegate addCircle:self];
            }

        });
    }
}


@end
