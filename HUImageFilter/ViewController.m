//
//  ViewController.m
//  HUImageFilter
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+filterImage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    
    NSLog(@"iamge view frame: %@", NSStringFromCGRect(self.imageView.bounds));
}


- (IBAction)addFilter:(id)sender {
    [self.imageView addFilter:^(HUImageFilterMaker *maker) {
        //maker.boxBlur(@40);
        //maker.discBlur(@4);
        //maker.gaussianBlur(@8);
       // maker.motionBlur(@10, @(M_1_PI));
        //maker.zoomBlur(@10,@10,@10);
        //maker.noiseReduction(@10);
        maker.medianFilter();
        //UIImage *b = [UIImage imageNamed:@"b.jpeg"];

//        maker.colorMap(b);
        //maker.colorMonochrome(@0.8);
        //maker.colorPosterize();
        //maker.falseColor([UIColor redColor], [UIColor yellowColor]);
    }];
    
}

- (IBAction)reset:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"a.jpg"];
}


- (void)filter1 {
    
}

@end
