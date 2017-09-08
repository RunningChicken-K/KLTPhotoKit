//
//  KLTRenderQueue.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/6/19.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTRenderQueue.h"
#import "KLTImageUploaderDefine.h"
@interface KLTRenderQueue ()

@property(nonatomic,strong)NSMutableArray * taskArray;
@property(nonatomic,strong)NSOperationQueue * renderQueue;

@property(nonatomic,strong)CIContext * context;

@property(nonatomic,strong)NSBlockOperation * nextOperation;



@end

@implementation KLTRenderQueue


- (void)addRenderWithSourceImage:(UIImage *)sourceImage Effect:(NSDictionary *)effect CubeMap:(struct CubeMap)cubeMap ColorControl:(struct ColorControl)colorControl Completion:(void (^)(UIImage * resultImage))completion
{
    NSBlockOperation * blockOp = [NSBlockOperation blockOperationWithBlock:^{
        CGRect targetRect = CGRectMake(0, 0,sourceImage.size.width, sourceImage.size.height);
        CGImageRef cgimg = [sourceImage CGImage];
        __block CIImage * ciimg = [CIImage imageWithCGImage:cgimg];
        
        if (effect) {
            if (![[effect.allKeys firstObject] isEqualToString:kNoneEffect]) {
                CIFilter * filter = [CIFilter filterWithName:[effect.allKeys firstObject]];
                [filter setValue:ciimg forKey:kCIInputImageKey];
                
                NSDictionary * parameters = [effect.allValues firstObject];
                if (![parameters isEqual:@""]) {
                    //NSLog(@"参数是%@",parameters);
                    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        //NSLog(@"key is %@\n value is %@",key,obj);
                        [filter setValue:obj forKey:key];
                    }];
                }
                
                ciimg = [filter valueForKey:kCIOutputImageKey];
            }
            
        }
        if ([[effect.allKeys firstObject] isEqualToString:kCILineOverlay]) {
            //“素描”生成的图片所有白色部分会被渲染为透明   因此要合成一张白色背景
            //生成一张纯白色背景
            CIImage * constantColor = [[CIFilter filterWithName:kCIConstantColorGenerator withInputParameters:@{@"inputColor":[CIColor whiteColor]}] valueForKey:kCIOutputImageKey];
            
            CIFilter * compositeFilter = [CIFilter filterWithName:kCISourceOverCompositing];
            [compositeFilter setValue:ciimg forKey:kCIInputImageKey];
            [compositeFilter setValue:constantColor forKey:kCIInputBackgroundImageKey];
            
            ciimg = [compositeFilter valueForKey:kCIOutputImageKey];
            
        }
        if (cubeMap.data) {
            //freeWhenDone  设置为No  防止cubeData销毁时直接销毁cubeMap
            NSData *cubeData = [NSData dataWithBytesNoCopy:cubeMap.data
                                                    length:cubeMap.length
                                              freeWhenDone:NO];
            CIFilter * filter = [CIFilter filterWithName:@"CIColorCube" withInputParameters:@{@"inputCubeDimension": @(cubeMap.dimension),@"inputCubeData": cubeData}];
            [filter setValue:ciimg forKey:kCIInputImageKey];
            
            ciimg = [filter valueForKey:kCIOutputImageKey];
        }
        
        if (colorControl.con){
            CIFilter * colorControlFilter = [CIFilter filterWithName:kCIColorControls withInputParameters:@{@"inputBrightness":@(colorControl.bri),@"inputContrast":@(colorControl.con),@"inputSaturation":@(colorControl.sat)}];
            [colorControlFilter setValue:ciimg forKey:kCIInputImageKey];
            
            ciimg = [colorControlFilter valueForKey:kCIOutputImageKey];
        }
        
        
        
        CGImageRef cgres = [self.context createCGImage:ciimg fromRect:targetRect];
        UIImage * result = [UIImage imageWithCGImage:cgres];
        //NSLog(@"%@",result);
        CGImageRelease(cgres);
        
        
        
        dispatch_main_sync_safe(^{
            if (completion) {
                completion(result);
            }
            [self continueRender];
        });

    }];
    
    self.nextOperation = blockOp;
    if (self.renderQueue.operations.count == 0) {
        [self continueRender];
    }
}
- (CIContext *)context
{
    if (_context == nil) {
        _context = [CIContext contextWithOptions: nil];
    }
    return _context;
}
- (void)continueRender
{
    [self.renderQueue addOperation:self.nextOperation];
    self.nextOperation = nil;
}
- (NSMutableArray *)taskArray
{
    if (_taskArray == nil) {
        _taskArray = [[NSMutableArray alloc]init];
    }
    return _taskArray;
}
- (NSOperationQueue *)renderQueue
{
    if (_renderQueue == nil) {
        _renderQueue = [[NSOperationQueue alloc]init];
    }
    return _renderQueue;
}

@end
