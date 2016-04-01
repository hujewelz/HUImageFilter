//
//  UIImageView+filterImage.m
//  HUImageFilter
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "UIImageView+filterImage.h"


@implementation UIImageView (filterImage)

- (void)addFilter:(void(^)(HUImageFilterMaker *maker))filterBlock {
    __block UIImage *image = self.image;
    if (image) {
        HUImageFilterMaker *filter = [[HUImageFilterMaker alloc] init];
        filter.inputImage = image;
        if (filterBlock ) {
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                filterBlock(filter);
                image = filter.outPutImage;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            });
            
        }
    }
   
    
}

@end
