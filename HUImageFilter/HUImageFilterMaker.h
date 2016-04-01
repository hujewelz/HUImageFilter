//
//  HUImageFilterMaker.h
//  HUImageFilter
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUImageFilterMaker : NSObject

@property (nonatomic, strong) UIImage *inputImage;
@property (nonatomic,readonly, strong) UIImage *outPutImage;


- (HUImageFilterMaker *(^)(NSNumber *radius))boxBlur;
- (HUImageFilterMaker *(^)(NSNumber *radius))discBlur;
- (HUImageFilterMaker *(^)(NSNumber *radius))gaussianBlur;
- (HUImageFilterMaker *(^)(NSNumber *sharp))noiseReduction;
- (HUImageFilterMaker *(^)(NSNumber *radius, NSNumber *angle))motionBlur;
- (HUImageFilterMaker *(^)(NSNumber *radius, NSNumber *x, NSNumber *y))zoomBlur;
- (HUImageFilterMaker *(^)(void))medianFilter;


- (HUImageFilterMaker *(^)(NSNumber *radius, NSNumber *x, NSNumber *y, NSNumber *scale))bumpDistortion;

- (HUImageFilterMaker *(^)(NSNumber *radius, NSNumber *x, NSNumber *y))circleSplashDistortion;

/**颜色反转*/
- (HUImageFilterMaker *(^)(void))colorInvert;

/**
 * maps (transforms) the colors of one (source) image to the colors of another (target) image
 *@param gradientImage The image data from this image transforms the source image values.
 */
- (HUImageFilterMaker *(^)(UIImage *gradientImage))colorMap;

/**
 * 单色效果 intensity: 亮度
 * The intensity of the monochrome effect. A value of 1.0 creates a monochrome image using the supplied color
 */
- (HUImageFilterMaker *(^)(NSNumber *intensity))colorMonochrome;

/**色彩分离*/
- (HUImageFilterMaker *(^)(void))colorPosterize;

/**伪色*/
- (HUImageFilterMaker *(^)(UIColor *color0, UIColor *color1))falseColor;

/**铬黄*/
- (HUImageFilterMaker *(^)(void))effectChrome;

/**铬黄*/
- (HUImageFilterMaker *(^)(void))effectFade;

/**铬黄*/
- (HUImageFilterMaker *(^)(void))effectInstant;

@end