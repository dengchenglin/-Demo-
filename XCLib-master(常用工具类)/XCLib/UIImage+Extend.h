

#import <UIKit/UIKit.h>

/**
 Image type.
 */
typedef NS_ENUM(NSUInteger, XCImageType) {
    XCImageTypeUnknown = 0, ///< unknown
    XCImageTypeJPEG,        ///< jpeg, jpg
    XCImageTypeJPEG2000,    ///< jp2
    XCImageTypeTIFF,        ///< tiff, tif
    XCImageTypeBMP,         ///< bmp
    XCImageTypeICO,         ///< ico
    XCImageTypeICNS,        ///< icns
    XCImageTypeGIF,         ///< gif
    XCImageTypePNG,         ///< png
    XCImageTypeWebP,        ///< webp
    XCImageTypeOther,       ///< other image format
};

@interface UIImage (Extend)
/**
 *  获取图片类型
 *
 *  @param imageData 图片数据
 *
 *  @return 图片类型
 */
+ (XCImageType)imageDetectType:(NSData *)imageData;
/**
 *  拉伸图片(拉伸中间位置)
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)resizedImage;
/**
 *  拉伸图片，指定区域,图片名称(使用@1x的图片)
 *
 *  @param edge      保留区域
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)resizedImageWithEdge:(UIEdgeInsets)edge;
/**
 *  缩放图片到指定大小
 *
 *  @param scaleSize 缩放的尺寸
 *
 *  @return 缩放后的图片
 */
- (UIImage *)scaleImageWithSize:(CGSize)scaleSize;
/**
 *  修复图片方向
 *
 *  @return 修复后的图片
 */
- (UIImage *)fixOrientation;
/**
 *  加载bundle下的png图片(文件名称必须是包含@2x/3x完整的名称)
 *
 *  @param imageName 图片文件名称不带@2/3x后缀
 *
 *  @return 加载的图片
 */
+ (UIImage *)imageFromBundleWithName:(NSString *)imageName;
@end

@interface UIImage (Create)
/**
 *  使用颜色生成指定大小的图片
 *
 *  @param color 图片颜色
 *  @param size  图片尺寸
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
/**
 *  图片着色
 *
 *  @param tintColor 颜色
 *
 *  @return
 */
-(UIImage *)imageWithTintColor:(UIColor *)tintColor;
/**
 *  图片着色保持原有的颜色
 *
 *  @param tintColor 颜色
 *
 *  @return
 */
-(UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
@end

@interface UIImage (Make)
/**
 *  生成圆角图片
 *
 *  @param radius 圆角的角度
 *
 *  @return 圆角图片
 */
-(UIImage *)makeRoundedRectImageWithRadius:(NSInteger)radius;
/**
 *  生成带边框的圆形图片
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return
 */
-(UIImage *)makeCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  生成默认圆角图片(根据当前图片size大小)
 *
 *  @return
 */
-(UIImage *)makeCircleImage;
@end