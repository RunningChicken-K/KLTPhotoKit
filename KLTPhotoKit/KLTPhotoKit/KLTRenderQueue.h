//
//  KLTRenderQueue.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/6/19.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLTFilter.h"

@interface KLTRenderQueue : NSObject

- (void)addRenderWithSourceImage:(UIImage *)sourceImage Effect:(NSDictionary *)effect CubeMap:(struct CubeMap)cubeMap ColorControl:(struct ColorControl)colorControl Completion:(void (^)(UIImage * resultImage))completion;

@end
