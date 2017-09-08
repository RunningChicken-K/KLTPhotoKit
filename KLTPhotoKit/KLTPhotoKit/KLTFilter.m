//
//  KLTFilter.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/8.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTFilter.h"
#import "KLTImageUploaderDefine.h"
#import "KLTRenderQueue.h"

void rgbToHSV(float *rgb, float *hsv) {
    float min, max, delta;
    float r = rgb[0], g = rgb[1], b = rgb[2];
    float *h = hsv, *s = hsv + 1, *v = hsv + 2;
    
    min = fmin(fmin(r, g), b );
    max = fmax(fmax(r, g), b );
    *v = max;
    delta = max - min;
    if( max != 0 )
        *s = delta / max;
    else {
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;
    else if( g == max )
        *h = 2 + ( b - r ) / delta;
    else
        *h = 4 + ( r - g ) / delta;
    *h *= 60;
    if( *h < 0 )
        *h += 360;
}

/**
 生成HSV中某个角度范围的颜色为透明的颜色查找表
 */
struct CubeMap createNoneColorCubeMap(float minHueAngle, float maxHueAngle) {
    const unsigned int size = 64;
    struct CubeMap map;
    map.length = size * size * size * sizeof (float) * 4;
    map.dimension = size;
    float *cubeData = (float *)malloc (map.length);
    float rgb[3], hsv[3], *c = cubeData;
    
    for (int z = 0; z < size; z++){
        rgb[2] = ((double)z)/(size-1); // Blue value
        for (int y = 0; y < size; y++){
            rgb[1] = ((double)y)/(size-1); // Green value
            for (int x = 0; x < size; x ++){
                rgb[0] = ((double)x)/(size-1); // Red value
                rgbToHSV(rgb,hsv);
                // Use the hue value to determine which to make transparent
                // The minimum and maximum hue angle depends on
                // the color you want to remove
                float alpha = (hsv[0] > minHueAngle && hsv[0] < maxHueAngle) ? 0.0f: 1.0f;
                // Calculate premultiplied alpha values for the cube
                c[0] = rgb[0] * alpha;
                c[1] = rgb[1] * alpha;
                c[2] = rgb[2] * alpha;
                c[3] = alpha;
                c += 4; // advance our pointer into memory for the next color value
            }
        }
    }
    map.data = cubeData;
    return map;
}
//生成颜色查找表  r,g,b值即为要映射的值   1.0为保持不变  0为透明
struct CubeMap createCubeMap(float red,float green,float blue,const unsigned int dimension)
{
    
    const unsigned int size = dimension;
    struct CubeMap map;
    map.length = size * size * size * sizeof (float) * 4;
    map.dimension = size;
    float *cubeData = (float *)malloc (map.length);
    for (int b = 0; b < size; b++) {
        for (int g = 0; g < size; g++) {
            for (int r = 0; r < size; r ++) {
                int dataOffset = (b*size*size + g*size + r) * 4;
                cubeData[dataOffset] = red * r/size;
                cubeData[dataOffset + 1] = green * g / size;
                cubeData[dataOffset + 2] = blue * b / size;
                cubeData[dataOffset + 3] = 1.0;
            }
        }
    }
    map.data = cubeData;
    return map;
}




struct ColorControl createColorControl(float bri,float con,float sat)
{
    struct ColorControl cc;
    cc.bri = bri;
    cc.con = con;
    cc.sat = sat;
    
    return cc;
};

@interface KLTFilter ()


@property(nonatomic,copy)NSDictionary * effectFilter;

@property(nonatomic,strong)NSOperationQueue * operationQueue;



@property(nonatomic,strong)UIImage * resultImage;

@property(nonatomic,assign) struct CubeMap  cubeMap;

@property(nonatomic,assign)struct ColorControl  colorControl;

@property(nonatomic,strong)CIContext * context;

@property(nonatomic,assign)NSInteger  count;

@property(atomic,strong)NSMutableArray * operationArray;





@end

@implementation KLTFilter


+(NSDictionary *)allFilter
{
    return @{@"CICategoryBlur":@[kCIBoxBlur,
                                 kCIDiscBlur,
                                 kCIGaussianBlur,
                                 kCIMaskedVariableBlur,
                                 kCIMedianFilter,
                                 kCIMotionBlur,
                                 kCINoiseReduction,
                                 kCIZoomBlur],
             @"CICategoryColorAdjustment":@[kCIColorClamp,
                                            kCIColorControls,
                                            kCIColorMatrix,
                                            kCIColorPolynomial,
                                            kCIExposureAdjust,
                                            kCIGammaAdjust,
                                            kCIHueAdjust,
                                            kCILinearToSRGBToneCurve,
                                            kCISRGBToneCurveToLinear,
                                            kCITemperatureAndTint,
                                            kCIToneCurve,
                                            kCIVibrance,
                                            kCIWhitePointAdjust],
             @"CICategoryColorEffect":@[kCIColorCrossPolynomial,
                                        kCIColorCube,
                                        kCIColorCubeWithColorSpace,
                                        kCIColorInvert,
                                        kCIColorMap,
                                        kCIColorMonochrome,
                                        kCIColorPosterize,
                                        kCIFalseColor,
                                        kCIMaskToAlpha,
                                        kCIMaximumComponent,
                                        kCIMinimumComponent,
                                        kCIPhotoEffectChrome,
                                        kCIPhotoEffectFade,
                                        kCIPhotoEffectInstant,
                                        kCIPhotoEffectMono,
                                        kCIPhotoEffectNoir,
                                        kCIPhotoEffectProcess,
                                        kCIPhotoEffectTonal,
                                        kCIPhotoEffectTransfer,
                                        kCISepiaTone,
                                        kCIVignette,
                                        kCIVignetteEffect],
             @"CICategoryCompositeOperation":@[kCIAdditionCompositing,
                                               kCIColorBlendMode,
                                               kCIColorBurnBlendMode,
                                               kCIColorDodgeBlendMode,
                                               kCIDarkenBlendMode,
                                               kCIDifferenceBlendMode,
                                               kCIDivideBlendMode,
                                               kCIExclusionBlendMode,
                                               kCIHardLightBlendMode,
                                               kCIHueBlendMode,
                                               kCILightenBlendMode,
                                               kCILinearBurnBlendMode,
                                               kCILinearDodgeBlendMode,
                                               kCILuminosityBlendMode,
                                               kCIMaximumCompositing,
                                               kCIMinimumCompositing,
                                               kCIMultiplyBlendMode,
                                               kCIMultiplyCompositing,
                                               kCIOverlayBlendMode,
                                               kCIPinLightBlendMode,
                                               kCISaturationBlendMode,
                                               kCIScreenBlendMode,
                                               kCISoftLightBlendMode,
                                               kCISourceAtopCompositing,
                                               kCISourceInCompositing,
                                               kCISourceOutCompositing,
                                               kCISourceOverCompositing,
                                               kCISubtractBlendMode],
             @"CICategoryDistortionEffect":@[kCIBumpDistortion,
                                             kCIBumpDistortionLinear,
                                             kCICircleSplashDistortion,
                                             kCICircularWrap,
                                             kCIDroste,
                                             kCIDisplacementDistortion,
                                             kCIGlassDistortion,
                                             kCIGlassLozenge,
                                             kCIHoleDistortion,
                                             kCILightTunnel,
                                             kCIPinchDistortion,
                                             kCIStretchCrop,
                                             kCITorusLensDistortion,
                                             kCITwirlDistortion,
                                             kCIVortexDistortion],
             @"CICategoryGenerator":@[kCIAztecCodeGenerator,
                                      kCICheckerboardGenerator,
                                      kCICode128BarcodeGenerator,
                                      kCIConstantColorGenerator,
                                      kCILenticularHaloGenerator,
                                      kCIPDF417BarcodeGenerator,
                                      kCIQRCodeGenerator,
                                      kCIRandomGenerator,
                                      kCIStarShineGenerator,
                                      kCIStripesGenerator,
                                      kCISunbeamsGenerator],
             @"CICategoryGeometryAdjustment":@[kCIAffineTransform,
                                               kCICrop,
                                               kCILanczosScaleTransform,
                                               kCIPerspectiveCorrection,
                                               kCIPerspectiveTransform,
                                               kCIPerspectiveTransformWithExtent,
                                               kCIStraightenFilter],
             @"CICategoryGradient":@[kCIGaussianGradient,
                                     kCILinearGradient,
                                     kCIRadialGradient,
                                     kCISmoothLinearGradient],
             @"CICategoryHalftoneEffect":@[ kCICircularScreen ,
                                            kCICMYKHalftone,
                                            kCIDotScreen,
                                            kCIHatchedScreen,
                                            kCILineScreen],
             @"CICategoryReduction":@[kCIAreaAverage,
                                      kCIAreaHistogram,
                                      kCIRowAverage,
                                      kCIColumnAverage,
                                      kCIHistogramDisplayFilter,
                                      kCIAreaMaximum,
                                      kCIAreaMinimum,
                                      kCIAreaMaximumAlpha,
                                      kCIAreaMinimumAlpha],
             @"CICategorySharpen":@[kCISharpenLuminance,
                                    kCIUnsharpMask],
             @"CICategoryStylize":@[kCIBlendWithAlphaMask ,
                                    kCIBlendWithMask,
                                    kCIBloom,
                                    kCIComicEffect,
                                    kCIConvolution3X3,
                                    kCIConvolution5X5,
                                    kCIConvolution7X7,
                                    kCIConvolution9Horizontal,
                                    kCIConvolution9Vertical,
                                    kCICrystallize,
                                    kCIDepthOfField,
                                    kCIEdges,
                                    kCIEdgeWork ,
                                    kCIGloom,
                                    kCIHeightFieldFromMask,
                                    kCIHexagonalPixellate,
                                    kCIHighlightShadowAdjust,
                                    kCILineOverlay,
                                    kCIPixellate,
                                    kCIPointillize,
                                    kCIShadedMaterial,
                                    kCISpotColor,
                                    kCISpotLight],
             @"CICategoryTileEffect":@[kCIAffineClamp,
                                       kCIAffineTile,
                                       kCIEightfoldReflectedTile,
                                       kCIFourfoldReflectedTile,
                                       kCIFourfoldRotatedTile,
                                       kCIFourfoldTranslatedTile,
                                       kCIGlideReflectedTile,
                                       kCIKaleidoscope,
                                       kCIOpTile,
                                       kCIParallelogramTile,
                                       kCIPerspectiveTile,
                                       kCISixfoldReflectedTile,
                                       kCISixfoldRotatedTile,
                                       kCITriangleKaleidoscope,
                                       kCITriangleTile,
                                       kCITwelvefoldReflectedTile],
             @"CICategoryTransition":@[kCIAccordionFoldTransition,
                                       kCIBarsSwipeTransition,
                                       kCICopyMachineTransition,
                                       kCIDisintegrateWithMaskTransition,
                                       kCIDissolveTransition,
                                       kCIFlashTransition,
                                       kCIModTransition,
                                       kCIPageCurlTransition,
                                       kCIPageCurlWithShadowTransition,
                                       kCIRippleTransition,
                                       kCISwipeTransition]};
}


+ (instancetype)filterWithSourceImage:(UIImage *)sourceImage
{
    return [[self alloc]initWithSourceImage:sourceImage];
}
- (instancetype)initWithSourceImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        //self.filters = [NSMutableDictionary dictionary];
        self.sourceImage = image;
        self.operationQueue = [[NSOperationQueue alloc]init];
        
    }
    return self;
}

- (void)setEffectFilter:(NSString *)filter Parameters:(NSDictionary *)parameters
{
    if (filter) {
        self.effectFilter = [NSDictionary dictionaryWithObject:parameters?parameters:@"" forKey:filter];
    }
}
- (void)setColorCubeWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue
{
    //根据传入的参数 创建新的色彩查找表
    self.cubeMap = createCubeMap(red, green, blue, 64);

}

- (CIContext *)context
{
    if (_context == nil) {
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
}
- (void)setCubeMap:(struct CubeMap)cubeMap
{
    if (_cubeMap.length) {
        free(_cubeMap.data);
    }
    _cubeMap = cubeMap;
}
- (void)setColorControlWithBrightness:(CGFloat)bri Contrast:(CGFloat)con Saturation:(CGFloat)sat
{
    self.colorControl = createColorControl(bri, con, sat);

}


- (void)render:(void (^)(UIImage * resultImage))completion
{
    /*
    KLTRenderQueue * renderQueue = [[KLTRenderQueue alloc]init];
    
    [renderQueue addRenderWithSourceImage:self.sourceImage Effect:self.effectFilter CubeMap:self.cubeMap ColorControl:self.colorControl Completion:^(UIImage *resultImage) {
        if (completion) {
            completion(resultImage);
        }
    }];
     **/
    
    
    NSBlockOperation * blockOp = [NSBlockOperation blockOperationWithBlock:^{
        CGRect targetRect = CGRectMake(0, 0, self.sourceImage.size.width, self.sourceImage.size.height);
        CGImageRef cgimg = [self.sourceImage CGImage];
        __block CIImage * ciimg = [CIImage imageWithCGImage:cgimg];
        
        if (self.effectFilter) {
            if (![[self.effectFilter.allKeys firstObject] isEqualToString:kNoneEffect]) {
                CIFilter * filter = [CIFilter filterWithName:[self.effectFilter.allKeys firstObject]];
                [filter setValue:ciimg forKey:kCIInputImageKey];
                
                NSDictionary * parameters = [self.effectFilter.allValues firstObject];
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
        if ([[self.effectFilter.allKeys firstObject] isEqualToString:kCILineOverlay]) {
            //“素描”生成的图片所有白色部分会被渲染为透明   因此要合成一张白色背景
            //生成一张纯白色背景
            CIImage * constantColor = [[CIFilter filterWithName:kCIConstantColorGenerator withInputParameters:@{@"inputColor":[CIColor whiteColor]}] valueForKey:kCIOutputImageKey];
            
            CIFilter * compositeFilter = [CIFilter filterWithName:kCISourceOverCompositing];
            [compositeFilter setValue:ciimg forKey:kCIInputImageKey];
            [compositeFilter setValue:constantColor forKey:kCIInputBackgroundImageKey];
            
            ciimg = [compositeFilter valueForKey:kCIOutputImageKey];
            
        }
        if (self.cubeMap.data) {
            //freeWhenDone  设置为No  防止cubeData销毁时直接销毁cubeMap
            NSData *cubeData = [NSData dataWithBytesNoCopy:self.cubeMap.data
                                                    length:self.cubeMap.length
                                              freeWhenDone:NO];
            CIFilter * filter = [CIFilter filterWithName:@"CIColorCube" withInputParameters:@{@"inputCubeDimension": @(self.cubeMap.dimension),@"inputCubeData": cubeData}];
            [filter setValue:ciimg forKey:kCIInputImageKey];
            
            ciimg = [filter valueForKey:kCIOutputImageKey];
        }

        if (self.colorControl.con){
            CIFilter * colorControlFilter = [CIFilter filterWithName:kCIColorControls withInputParameters:@{@"inputBrightness":@(self.colorControl.bri),@"inputContrast":@(self.colorControl.con),@"inputSaturation":@(self.colorControl.sat)}];
            [colorControlFilter setValue:ciimg forKey:kCIInputImageKey];
            
            ciimg = [colorControlFilter valueForKey:kCIOutputImageKey];
        }
        
    
        
        CGImageRef cgres = [self.context createCGImage:ciimg fromRect:targetRect];
        UIImage * result = [UIImage imageWithCGImage:cgres];
        //NSLog(@"%@",result);
        CGImageRelease(cgres);
        
        NSLog(@"%ld",(long)_count);
       

        dispatch_main_sync_safe(^{
            if (completion) {
                completion(result);
            }
        });

    }];
    
    [self.operationQueue addOperation:blockOp];
    
}

- (void)clearFilters
{
    
}

- (void)dealloc
{
    if (_cubeMap.length) {
        free(_cubeMap.data);
    }
}



@end



























