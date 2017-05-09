//
//  KLTFilter.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/8.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTFilter.h"

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
                                               kCISourceOverCompositing],
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












@end



























