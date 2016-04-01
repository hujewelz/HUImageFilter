//
//  UIImageView+filterImage.h
//  HUImageFilter
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUImageFilterMaker.h"

@interface UIImageView (filterImage)

- (void)addFilter:(void(^)(HUImageFilterMaker *maker))filterBlock;
@end
