//
//  HUImageFilterMaker.m
//  HUImageFilter
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "HUImageFilterMaker.h"
#import <CoreImage/CoreImage.h>


@interface HUImageFilterMaker ()

@property (nonatomic, strong) CIImage *outPut;

@end
@implementation HUImageFilterMaker

#pragma mark - filter Blur

- (HUImageFilterMaker *(^)(NSNumber *))boxBlur {
    return ^(NSNumber *r) {
        return [self addBoxBlur:r];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *))discBlur {
    return ^(NSNumber *r) {
        return [self addDiscBlur:r];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *))gaussianBlur {
    return ^(NSNumber *r) {
        return [self addGaussianBlur:r];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *))noiseReduction {
    return ^(NSNumber *s) {
        return [self addNoiseReduction:s];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *, NSNumber *))motionBlur {
    return ^(NSNumber *r, NSNumber *a) {
        return [self addMotionBlur:r andAngle:a];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *, NSNumber *, NSNumber *))zoomBlur {
    return ^(NSNumber *r, NSNumber *x, NSNumber *y) {
        return [self addZoomBlur:r andX:x Y:y];
    };
}

- (HUImageFilterMaker *(^)(void))medianFilter {
    return ^{
        return [self addMedianFilter];
    };
}

#pragma mark - distortion effect

- (HUImageFilterMaker *(^)(NSNumber *, NSNumber *, NSNumber *, NSNumber *))bumpDistortion {
    return ^(NSNumber *r, NSNumber *x, NSNumber *y, NSNumber *s) {
        return [self addDistortion:r andX:x Y:y scale:s];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *, NSNumber *, NSNumber *))circleSplashDistortion {
    return ^(NSNumber *r, NSNumber *x, NSNumber *y) {
        return [self addCircleSplashDistortion:r andX:x Y:y];
    };
}


#pragma mark - color effect

- (HUImageFilterMaker *(^)(void))colorInvert {
    return ^{
        return [self addColorInvert];
    };
}

- (HUImageFilterMaker *(^)(UIImage *))colorMap {
    return ^(UIImage *image){
        return [self addColorMapWithGradientImage:image];
    };
}

- (HUImageFilterMaker *(^)(NSNumber *))colorMonochrome {
    return ^(NSNumber *ide) {
        return [self addColorMonochromeWithValue:ide];
    };
}

- (HUImageFilterMaker *(^)(void))colorPosterize {
    return ^{
        return [self addColorPosterize];
    };
}

- (HUImageFilterMaker *(^)(UIColor *, UIColor *))falseColor {
    return ^(UIColor *c0, UIColor *c1) {
        return [self addFalseColorWithColor0:c0 andColor1:c1];
    };
}

- (HUImageFilterMaker *(^)(void))effectChrome {
    return  ^{
        return [self addEffectChrome];
    };
}

- (HUImageFilterMaker *(^)(void))effectFade {
    return  ^{
        return [self addEffectFade];
    };
}

- (HUImageFilterMaker *(^)(void))effectInstant {
    return  ^{
        return [self addEffectInstant];
    };
}




#pragma mark - add blur filter

/**
 *kCICategoryBlur 模糊
 * 1.CIBoxBlur: inputImage=nil inputRadius=10
 * 2.CIDiscBlur: inputImage=nil inputRadius=8
 * 3.CIGaussianBlur: inputImage=nil inputRadius=10 高斯模糊
 * 4.CIMedianFilter: inputImage=nil
 * 5.CIMotionBlur: inputImage=nil inputRadius=20 inputAngle=0
 * 6.CINoiseReduction: inputImage=nil inputRadius=10 动感模糊
 * 7.CIZoomBlur: inputImage=nil inputCenter=[150 150] inputAmount=20
 */

- (HUImageFilterMaker *)addBoxBlur:(NSNumber *)radius {
    
    [self addFiterWithName:@"CIBoxBlur" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
    }];
    
    return self;
}

- (HUImageFilterMaker *)addDiscBlur:(NSNumber *)radius {
    
    [self addFiterWithName:@"CIDiscBlur" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
    }];
    
    return self;
}

- (HUImageFilterMaker *)addGaussianBlur:(NSNumber *)radius {

    [self addFiterWithName:@"CIGaussianBlur" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
    }];
    
    return self;
 }

- (HUImageFilterMaker *)addMedianFilter {
    //CIMedianFilter
    [self addFiterWithName:@"CIMedianFilter" values:nil];
    
    return self;
}

- (HUImageFilterMaker *)addNoiseReduction:(NSNumber *)sharp {
    
    [self addFiterWithName:@"CINoiseReduction" values:^(CIFilter *filter) {
        [filter setValue:sharp forKey:kCIInputSharpnessKey];
    }];
    
    return self;
}

- (HUImageFilterMaker *)addMotionBlur:(NSNumber *)radius andAngle:(NSNumber *)angle {
    
    [self addFiterWithName:@"CIMotionBlur" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
        [filter setValue:angle forKey:kCIInputAngleKey];
    }];
    
    return self;
}

- (HUImageFilterMaker *)addZoomBlur:(NSNumber *)radius andX:(NSNumber *)x Y:(NSNumber *)y {
    
    [self addFiterWithName:@"CIZoomBlur" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
        CIVector *center = [CIVector vectorWithX:x.floatValue Y:y.floatValue];
        [filter setValue:center forKey:kCIInputCenterKey];
    }];
    
    return self;
}



#pragma mark - add color filter

/**
 * CICategoryColorEffect
 * 1.CIColorInvert //
 * 2.CIColorMap: inputImage=nil inputGradientImage 图片混合
 * 3.CIColorMonochrome: inputImage=nil inputRadius=10 高斯模糊
 * 4.CIColorPosterize: inputImage=nil
 * 5.CIColorMap: inputImage=nil inputRadius=20 inputAngle=0
 * 6.CIColorMonochrome: inputImage=nil inputRadius=10 动感模糊
 * 7.CIColorPosterize: inputImage=nil inputCenter=[150 150] inputAmount=20
 */

/**
 * 颜色反转
 * 对原像素点的RGB三个值，分别减去255然后取绝对值，新的 RGB值将取代原来的值。
 */
- (HUImageFilterMaker *)addColorInvert {
    
    [self addFiterWithName:@"CIColorInvert" values:nil];
    return self;
}


/**
 *color map
 *@param image The image data from this image transforms the source image values.
 */
- (HUImageFilterMaker *)addColorMapWithGradientImage:(UIImage *)image {
    
    [self addFiterWithName:@"CIColorMap" values:^(CIFilter *filter) {
        
        CIImage *inputGradientImage = [CIImage imageWithCGImage:image.CGImage];
        [filter setValue:inputGradientImage forKey:kCIInputGradientImageKey];
    }];
    
    return self;
}

/**单色*/
- (HUImageFilterMaker *)addColorMonochromeWithValue:(NSNumber *)value {
    
    [self addFiterWithName:@"CIColorMonochrome" values:^(CIFilter *filter) {
        [filter setValue:value forKey:kCIInputIntensityKey];
    }];
    return self;
}

/**色彩分离*/
- (HUImageFilterMaker *)addColorPosterize {
    [self addFiterWithName:@"CIPhotoEffectTonal" values:nil];

    return self;
}

/**伪色*/
- (HUImageFilterMaker *)addFalseColorWithColor0:(UIColor *)color0 andColor1:(UIColor *)color1 {
    //CIFalseColor
    [self addFiterWithName:@"CIPhotoEffectTonal" values:^(CIFilter *filter) {
//        CIColor *icolor0 = [CIColor colorWithCGColor:color0.CGColor];
//        CIColor *icolor1 = [CIColor colorWithCGColor:color1.CGColor];
//        [filter setValue:icolor0 forKey:kCIInputColorKey];
//        [filter setValue:icolor1 forKey:kCIInputColorKey];
    }];
    return self;
}

/**铬黄*/
- (HUImageFilterMaker *)addEffectChrome {
    [self addFiterWithName:@"CIPhotoEffectChrome" values:nil];
    return self;
}

/**fade*/
- (HUImageFilterMaker *)addEffectFade {
    [self addFiterWithName:@"CIPhotoEffectFade" values:nil];
    return self;
}

/**instant*/
- (HUImageFilterMaker *)addEffectInstant {
    [self addFiterWithName:@"CIPhotoEffectInstant" values:nil];
    return self;
}

#pragma mark - add distortion effect

/**
 * kCICategoryDistortionEffect 变形
 * 1.CIBumpDistortion //
 * 2.CIBumpDistortionLinear: inputImage=nil inputGradientImage 图片混合
 * 3.CICircleSplashDistortion: inputImage=nil inputRadius=10 高斯模糊
 * 4.CICircularWrap: inputImage=nil
 * 5.CIDisplacementDistortion: inputImage=nil inputRadius=20 inputAngle=0
 * 6.CIDroste: inputImage=nil inputRadius=10 动感模糊
 * 7.CIGlassDistortion: inputImage=nil inputCenter=[150 150] inputAmount=20
 */

- (HUImageFilterMaker *)addDistortion:(NSNumber *)radius andX:(NSNumber *)x Y:(NSNumber *)y scale:(NSNumber *)scale {
    
    [self addFiterWithName:@"CIBumpDistortion" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
        CIVector *center = [CIVector vectorWithX:x.floatValue Y:y.floatValue];
        [filter setValue:center forKey:kCIInputCenterKey];
        [filter setValue:scale forKey:kCIInputScaleKey];
    }];
    
    return self;
}

- (HUImageFilterMaker *)addCircleSplashDistortion:(NSNumber *)radius andX:(NSNumber *)x Y:(NSNumber *)y {
    
    [self addFiterWithName:@"CIBumpDistortion" values:^(CIFilter *filter) {
        [filter setValue:radius forKey:kCIInputRadiusKey];
        CIVector *center = [CIVector vectorWithX:x.floatValue Y:y.floatValue];
        [filter setValue:center forKey:kCIInputCenterKey];
    
    }];
    
    return self;
}

#pragma mark - private

- (void)addFiterWithName:(NSString *)filterName values:(void(^)(CIFilter* filter))block {
    [self logFilterWithName:filterName];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setValue:self.input forKey:kCIInputImageKey];
    
    if (block) {
        block(filter);
    }
    
    CIContext *contex = [CIContext contextWithOptions:nil];
    CIImage *outputImage = filter.outputImage;
    CGImageRef imageRef = [contex createCGImage:outputImage fromRect:self.input.extent];
    self.inputImage = [UIImage imageWithCGImage:imageRef];
}

- (void)logFilterWithName:(NSString *)name {
    NSLog(@"%@",[CIFilter filterNamesInCategory:kCICategoryDistortionEffect]);
    CIFilter *filter = [CIFilter filterWithName:name];
    NSLog(@"attribute: %@",filter.attributes);
}


- (UIImage *)outPutImage {
    return self.inputImage;
}

- (CIImage *)input {
    return [CIImage imageWithCGImage:_inputImage.CGImage];
}

@end
