//
//  UIImage+Resized.m
//  weibo
//
//  Created by xuchao on 14-8-8.
//  Copyright (c) 2014年 xuchao. All rights reserved.
//

#import "UIImage+Extend.h"

#define XC_FOUR_CC(c1,c2,c3,c4) ((uint32_t)(((c4) << 24) | ((c3) << 16) | ((c2) << 8) | (c1)))
#define XC_TWO_CC(c1,c2) ((uint16_t)(((c2) << 8) | (c1)))

static UIImage* circleImageCreate(UIImage *image ,CGFloat borderWidth ,UIColor *borderColor)
{
    //新图片大小
    CGFloat imageW = image.size.width + 2 * borderWidth;
    CGFloat imaheH = image.size.height + 2 * borderWidth;
    CGSize imageSize = {imageW,imaheH};
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置边框颜色
    if (borderColor) {
        [borderColor set];
    }
    //大圆圆心
    CGFloat bigRadius = imageW * 0.5;
    CGContextAddArc(ctx, bigRadius, bigRadius, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    //小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, bigRadius, bigRadius, smallRadius, 0, M_PI * 2, 0);
    //裁剪
    CGContextClip(ctx);
    //画图
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    //生成新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@implementation UIImage (Extend)

+ (XCImageType)imageDetectType:(NSData *)imageData
{
    if (!imageData) {
        return XCImageTypeUnknown;
    }
    CFDataRef data = (__bridge CFDataRef)(imageData);
    uint64_t length = CFDataGetLength(data);
    if (length < 16) {
        return XCImageTypeUnknown;
    }
    const char *bytes = (char *)CFDataGetBytePtr(data);
    uint32_t magic4 = *((uint32_t *)bytes);
    switch (magic4) {
        case XC_FOUR_CC(0x4D, 0x4D, 0x00, 0x2A): { // big endian TIFF
            return XCImageTypeTIFF;
        }
            break;
        case XC_FOUR_CC(0x49, 0x49, 0x2A, 0x00): { // little endian TIFF
            return XCImageTypeTIFF;
        }
            break;
        case XC_FOUR_CC(0x00, 0x00, 0x01, 0x00): { // ICO
            return XCImageTypeICO;
        }
            break;
        case XC_FOUR_CC(0x00, 0x00, 0x02, 0x00): { // CUR
            return XCImageTypeICO;
        }
            break;
        case XC_FOUR_CC('i', 'c', 'n', 's'): { // ICNS
            return XCImageTypeICNS;
        }
            break;
        case XC_FOUR_CC('G', 'I', 'F', '8'): { // GIF
            return XCImageTypeGIF;
        }
            break;
        case XC_FOUR_CC(0x89, 'P', 'N', 'G'): {  // PNG
            uint32_t tmp = *((uint32_t *)(bytes + 4));
            if (tmp == XC_FOUR_CC('\r', '\n', 0x1A, '\n')) {
                return XCImageTypePNG;
            }
        }
            break;
        case XC_FOUR_CC('R', 'I', 'F', 'F'): { // WebP
            uint32_t tmp = *((uint32_t *)(bytes + 8));
            if (tmp == XC_FOUR_CC('W', 'E', 'B', 'P')) {
                return XCImageTypeWebP;
            }
        } break;
            /*
             case XC_FOUR_CC('B', 'P', 'G', 0xFB): { // BPG
             return XCImageTypeBPG;
             } break;
             */
    }
    uint16_t magic2 = *((uint16_t *)bytes);
    switch (magic2) {
        case XC_TWO_CC('B', 'A'):
        case XC_TWO_CC('B', 'M'):
        case XC_TWO_CC('I', 'C'):
        case XC_TWO_CC('P', 'I'):
        case XC_TWO_CC('C', 'I'):
        case XC_TWO_CC('C', 'P'): { // BMP
            return XCImageTypeBMP;
        }
        case XC_TWO_CC(0xFF, 0x4F): { // JPEG2000
            return XCImageTypeJPEG2000;
        }
    }
    // JPG             FF D8 FF
    if (memcmp(bytes,"\377\330\377",3) == 0) {
        return XCImageTypeJPEG;
    }
    // JP2
    if (memcmp(bytes + 4, "\152\120\040\040\015", 5) == 0) {
        return XCImageTypeJPEG2000;
    }
    return XCImageTypeUnknown;
}

- (UIImage *)resizedImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

- (UIImage *)resizedImageWithEdge:(UIEdgeInsets)edge
{
    return [self resizableImageWithCapInsets:edge];
}

- (UIImage *)scaleImageWithSize:(CGSize)scaleSize
{
    //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    CGSize imageSize = self.size;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, imageSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, imageSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, imageSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, imageSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    CGImageRef cgImage = self.CGImage;
    CGContextRef ctx = CGBitmapContextCreate(NULL, imageSize.width, imageSize.height,
                                             CGImageGetBitsPerComponent(cgImage), 0,
                                             CGImageGetColorSpace(cgImage),
                                             CGImageGetBitmapInfo(cgImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,imageSize.height,imageSize.width), cgImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,imageSize.width,imageSize.height), cgImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    if (ctx) {
        CGContextRelease(ctx);
    }
    if (cgimg) {
        CGImageRelease(cgimg);
    }
    return img;
}

+ (UIImage *)imageFromBundleWithName:(NSString *)imageName
{
    if (imageName == nil) {
        return nil;
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *fileName = [NSString stringWithFormat:@"%@@%.0fx.png", imageName, scale];
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
}
@end

@implementation UIImage(Create)

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    //填充颜色
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}
@end

@implementation UIImage (Make)

- (UIImage *)makeRoundedRectImageWithRadius:(NSInteger)radius
{
    int w = self.size.width;
    int h = self.size.height;
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
    CGRect rect = CGRectMake(0, 0, w, h);
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    if (context) {
        CGContextRelease(context);
    }
    if (colorSpace) {
        CGColorSpaceRelease(colorSpace);
    }
    if (imageMasked) {
        CGImageRelease(imageMasked);
    }
    return img;
}

- (UIImage *)makeCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    return circleImageCreate(self, borderWidth, borderColor);
}

- (UIImage *)makeCircleImage
{
    return circleImageCreate(self, 0, nil);
}
@end