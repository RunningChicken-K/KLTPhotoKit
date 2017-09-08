//
//  KLTFilter.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/8.
//  Copyright © 2017年 KongLT. All rights reserved.
//


#import "FilterReference.h"
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

struct CubeMap {
    int length;
    float dimension;
    float *data;
};

struct ColorControl {
    float bri;
    float con;
    float sat;
};

@interface KLTFilter : NSObject

@property(nonatomic,strong)UIImage * sourceImage;

+ (NSDictionary *)allFilter;

+ (instancetype)filterWithSourceImage:(UIImage *)sourceImage;

- (void)setColorControlWithBrightness:(CGFloat)bri Contrast:(CGFloat)con Saturation:(CGFloat)sat;

- (void)setColorCubeWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

- (void)setEffectFilter:(NSString *)filter Parameters:(NSDictionary *)parameters;
//输出图片
- (void)render:(void(^)(UIImage * resultImage))completion;

- (void)clearFilters;

@end
