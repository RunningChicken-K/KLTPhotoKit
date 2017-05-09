//
//  KLTFilter.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/8.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <CoreImage/CoreImage.h>




#pragma mark- CICategoryBlur  模糊相关滤镜
static NSString * kCIBoxBlur = @"CIBoxBlur";//快速均值模糊
static NSString * kCIDiscBlur = @"CIDiscBlur";//环形卷积模糊
static NSString * kCIGaussianBlur = @"CIGaussianBlur";//高斯模糊
static NSString * kCIMaskedVariableBlur = @"CIMaskedVariableBlur";//提供一张图片 根据图片覆盖位置 根据提供的maskImage的灰度对源图片进行模糊 maskImg中从白到黑模糊程度递减
static NSString * kCIMedianFilter = @"CIMedianFilter";//中值模糊 用于消除图像噪点
static NSString * kCIMotionBlur = @"CIMotionBlur";//运动模糊 模拟运动过程中照到的照片
static NSString * kCINoiseReduction = @"CINoiseReduction";//降噪
static NSString * kCIZoomBlur = @"CIZoomBlur";//缩放模糊
#pragma mark- CICategoryColorAdjustment
static NSString * kCIColorClamp = @"CIColorClamp";//修改颜色到指定范围 指定值为RGBA 最小{0，0，0，0} 最大{1，1，1，1}  默认最小{0，0，0，0} 最大{1，1，1，1，1}
static NSString * kCIColorControls = @"CIColorControls";//调整图片的饱和度（默认为1），亮度和对比度（默认为1）
static NSString * kCIColorMatrix = @"CIColorMatrix";
static NSString * kCIColorPolynomial = @"CIColorPolynomial";
static NSString * kCIExposureAdjust = @"CIExposureAdjust";
static NSString * kCIGammaAdjust = @"CIGammaAdjust";
static NSString * kCIHueAdjust = @"CIHueAdjust";
static NSString * kCILinearToSRGBToneCurve = @"CILinearToSRGBToneCurve";
static NSString * kCISRGBToneCurveToLinear = @"CISRGBToneCurveToLinear";
static NSString * kCITemperatureAndTint = @"CITemperatureAndTint";
static NSString * kCIToneCurve = @"CIToneCurve";
static NSString * kCIVibrance = @"CIVibrance";
static NSString * kCIWhitePointAdjust = @"CIWhitePointAdjust";
#pragma mark- CICategoryColorEffect
static NSString * kCIColorCrossPolynomial = @"CIColorCrossPolynomial";
static NSString * kCIColorCube = @"CIColorCube";
static NSString * kCIColorCubeWithColorSpace = @"CIColorCubeWithColorSpace";
static NSString * kCIColorInvert = @"CIColorInvert";
static NSString * kCIColorMap = @"CIColorMap";
static NSString * kCIColorMonochrome = @"CIColorMonochrome";
static NSString * kCIColorPosterize = @"CIColorPosterize";
static NSString * kCIFalseColor = @"CIFalseColor";
static NSString * kCIMaskToAlpha = @"CIMaskToAlpha";
static NSString * kCIMaximumComponent = @"CIMaximumComponent";
static NSString * kCIMinimumComponent = @"CIMinimumComponent";
static NSString * kCIPhotoEffectChrome = @"CIPhotoEffectChrome";
static NSString * kCIPhotoEffectFade = @"CIPhotoEffectFade";
static NSString * kCIPhotoEffectInstant = @"CIPhotoEffectInstant";
static NSString * kCIPhotoEffectMono = @"CIPhotoEffectMono";
static NSString * kCIPhotoEffectNoir = @"CIPhotoEffectNoir";
static NSString * kCIPhotoEffectProcess = @"CIPhotoEffectProcess";
static NSString * kCIPhotoEffectTonal = @"CIPhotoEffectTonal";
static NSString * kCIPhotoEffectTransfer = @"CIPhotoEffectTransfer";
static NSString * kCISepiaTone = @"CISepiaTone";
static NSString * kCIVignette = @"CIVignette";
static NSString * kCIVignetteEffect = @"CIVignetteEffect";
#pragma mark- CICategoryCompositeOperation
static NSString * kCIAdditionCompositing = @"CIAdditionCompositing";
static NSString * kCIColorBlendMode = @"CIColorBlendMode";
static NSString * kCIColorBurnBlendMode = @"CIColorBurnBlendMode";
static NSString * kCIColorDodgeBlendMode = @"CIColorDodgeBlendMode";
static NSString * kCIDarkenBlendMode = @"CIDarkenBlendMode";
static NSString * kCIDifferenceBlendMode = @"CIDifferenceBlendMode";
static NSString * kCIDivideBlendMode = @"CIDivideBlendMode";
static NSString * kCIExclusionBlendMode = @"CIExclusionBlendMode";
static NSString * kCIHardLightBlendMode = @"CIHardLightBlendMode";
static NSString * kCIHueBlendMode = @"CIHueBlendMode";
static NSString * kCILightenBlendMode = @"CILightenBlendMode";
static NSString * kCILinearBurnBlendMode = @"CILinearBurnBlendMode";
static NSString * kCILinearDodgeBlendMode = @"CILinearDodgeBlendMode";
static NSString * kCILuminosityBlendMode = @"CILuminosityBlendMode";
static NSString * kCIMaximumCompositing = @"CIMaximumCompositing";
static NSString * kCIMinimumCompositing = @"CIMinimumCompositing";
static NSString * kCIMultiplyBlendMode = @"CIMultiplyBlendMode";
static NSString * kCIMultiplyCompositing = @"CIMultiplyCompositing";
static NSString * kCIOverlayBlendMode = @"CIOverlayBlendMode";
static NSString * kCIPinLightBlendMode = @"CIPinLightBlendMode";
static NSString * kCISaturationBlendMode = @"CISaturationBlendMode";
static NSString * kCIScreenBlendMode = @"CIScreenBlendMode";
static NSString * kCISoftLightBlendMode = @"CISoftLightBlendMode";
static NSString * kCISourceAtopCompositing = @"CISourceAtopCompositing";
static NSString * kCISourceInCompositing = @"CISourceInCompositing";
static NSString * kCISourceOutCompositing = @"CISourceOutCompositing";
static NSString * kCISourceOverCompositing = @"CISourceOverCompositing";
static NSString * kCISubtractBlendMode = @"CISubtractBlendMode";
#pragma mark- CICategoryDistortionEffect
static NSString * kCIBumpDistortion = @"CIBumpDistortion";
static NSString * kCIBumpDistortionLinear = @"CIBumpDistortionLinear";
static NSString * kCICircleSplashDistortion = @"CICircleSplashDistortion";
static NSString * kCICircularWrap = @"CICircularWrap";
static NSString * kCIDroste = @"CIDroste";
static NSString * kCIDisplacementDistortion = @"CIDisplacementDistortion";
static NSString * kCIGlassDistortion = @"CIGlassDistortion";
static NSString * kCIGlassLozenge = @"CIGlassLozenge";
static NSString * kCIHoleDistortion = @"CIHoleDistortion";
static NSString * kCILightTunnel = @"CILightTunnel";
static NSString * kCIPinchDistortion = @"CIPinchDistortion";
static NSString * kCIStretchCrop = @"CIStretchCrop";
static NSString * kCITorusLensDistortion= @"CITorusLensDistortion";
static NSString * kCITwirlDistortion = @"CITwirlDistortion";
static NSString * kCIVortexDistortion = @"CIVortexDistortion";
#pragma mark- CICategoryGenerator
static NSString * kCIAztecCodeGenerator = @"CIAztecCodeGenerator";
static NSString * kCICheckerboardGenerator = @"CICheckerboardGenerator";
static NSString * kCICode128BarcodeGenerator = @"CICode128BarcodeGenerator";
static NSString * kCIConstantColorGenerator = @"CIConstantColorGenerator";
static NSString * kCILenticularHaloGenerator = @"CILenticularHaloGenerator";
static NSString * kCIPDF417BarcodeGenerator = @"CIPDF417BarcodeGenerator";
static NSString * kCIQRCodeGenerator = @"CIQRCodeGenerator";
static NSString * kCIRandomGenerator = @"CIRandomGenerator";
static NSString * kCIStarShineGenerator = @"CIStarShineGenerator";
static NSString * kCIStripesGenerator = @"CIStripesGenerator";
static NSString * kCISunbeamsGenerator = @"CISunbeamsGenerator";
#pragma mark- CICategoryGeometryAdjustment
static NSString * kCIAffineTransform = @"CIAffineTransform";
static NSString * kCICrop = @"CICrop";
static NSString * kCILanczosScaleTransform = @"CILanczosScaleTransform";
static NSString * kCIPerspectiveCorrection = @"CIPerspectiveCorrection";
static NSString * kCIPerspectiveTransform = @"CIPerspectiveTransform";
static NSString * kCIPerspectiveTransformWithExtent = @"CIPerspectiveTransformWithExtent";
static NSString * kCIStraightenFilter = @"CIStraightenFilter";
#pragma mark- CICategoryGradient
static NSString * kCIGaussianGradient = @"CIGaussianGradient";
static NSString * kCILinearGradient = @"CILinearGradient";
static NSString * kCIRadialGradient = @"CIRadialGradient";
static NSString * kCISmoothLinearGradient = @"CISmoothLinearGradient";
#pragma mark- CICategoryHalftoneEffect
static NSString * kCICircularScreen = @"CICircularScreen";
static NSString * kCICMYKHalftone = @"CICMYKHalftone";
static NSString * kCIDotScreen = @"CIDotScreen";
static NSString * kCIHatchedScreen = @"CIHatchedScreen";
static NSString * kCILineScreen = @"CILineScreen";
#pragma mark- CICategoryReduction
static NSString * kCIAreaAverage = @"CIAreaAverage";
static NSString * kCIAreaHistogram = @"CIAreaHistogram";
static NSString * kCIRowAverage = @"CIRowAverage";
static NSString * kCIColumnAverage = @"CIColumnAverage";
static NSString * kCIHistogramDisplayFilter = @"CIHistogramDisplayFilter";
static NSString * kCIAreaMaximum = @"CIAreaMaximum";
static NSString * kCIAreaMinimum = @"CIAreaMinimum";
static NSString * kCIAreaMaximumAlpha = @"CIAreaMaximumAlpha";
static NSString * kCIAreaMinimumAlpha = @"CIAreaMinimumAlpha";
#pragma mark- CICategorySharpen
static NSString * kCISharpenLuminance = @"CISharpenLuminance";
static NSString * kCIUnsharpMask = @"CIUnsharpMask";
#pragma mark- CICategoryStylize
static NSString * kCIBlendWithAlphaMask = @"CIBlendWithAlphaMask";
static NSString * kCIBlendWithMask = @"CIBlendWithMask";
static NSString * kCIBloom = @"CIBloom";
static NSString * kCIComicEffect = @"CIComicEffect";
static NSString * kCIConvolution3X3 = @"CIConvolution3X3";
static NSString * kCIConvolution5X5 = @"CIConvolution5X5";
static NSString * kCIConvolution7X7 = @"CIConvolution7X7";
static NSString * kCIConvolution9Horizontal = @"CIConvolution9Horizontal";
static NSString * kCIConvolution9Vertical = @"CIConvolution9Vertical";
static NSString * kCICrystallize = @"CICrystallize";
static NSString * kCIDepthOfField = @"CIDepthOfField";
static NSString * kCIEdges = @"CIEdges";
static NSString * kCIEdgeWork = @"CIEdgeWork";
static NSString * kCIGloom = @"CIGloom";
static NSString * kCIHeightFieldFromMask = @"CIHeightFieldFromMask";
static NSString * kCIHexagonalPixellate = @"CIHexagonalPixellate";
static NSString * kCIHighlightShadowAdjust = @"CIHighlightShadowAdjust";
static NSString * kCILineOverlay = @"CILineOverlay";
static NSString * kCIPixellate = @"CIPixellate";
static NSString * kCIPointillize = @"CIPointillize";
static NSString * kCIShadedMaterial = @"CIShadedMaterial";
static NSString * kCISpotColor = @"CISpotColor";
static NSString * kCISpotLight = @"CISpotLight";
#pragma mark- CICategoryTileEffect
static NSString * kCIAffineClamp = @"CIAffineClamp";
static NSString * kCIAffineTile = @"CIAffineTile";
static NSString * kCIEightfoldReflectedTile = @"CIEightfoldReflectedTile";
static NSString * kCIFourfoldReflectedTile = @"CIFourfoldReflectedTile";
static NSString * kCIFourfoldRotatedTile = @"CIFourfoldRotatedTile";
static NSString * kCIFourfoldTranslatedTile = @"CIFourfoldTranslatedTile";
static NSString * kCIGlideReflectedTile = @"CIGlideReflectedTile";
static NSString * kCIKaleidoscope = @"CIKaleidoscope";
static NSString * kCIOpTile = @"CIOpTile";
static NSString * kCIParallelogramTile = @"CIParallelogramTile";
static NSString * kCIPerspectiveTile = @"CIPerspectiveTile";
static NSString * kCISixfoldReflectedTile = @"CISixfoldReflectedTile";
static NSString * kCISixfoldRotatedTile = @"CISixfoldRotatedTile";
static NSString * kCITriangleKaleidoscope = @"CITriangleKaleidoscope";
static NSString * kCITriangleTile = @"CITriangleTile";
static NSString * kCITwelvefoldReflectedTile = @"CITwelvefoldReflectedTile";
#pragma mark- CICategoryTransition
static NSString * kCIAccordionFoldTransition = @"CIAccordionFoldTransition";
static NSString * kCIBarsSwipeTransition = @"CIBarsSwipeTransition";
static NSString * kCICopyMachineTransition = @"CICopyMachineTransition";
static NSString * kCIDisintegrateWithMaskTransition = @"CIDisintegrateWithMaskTransition";
static NSString * kCIDissolveTransition = @"CIDissolveTransition";
static NSString * kCIFlashTransition = @"CIFlashTransition";
static NSString * kCIModTransition = @"CIModTransition";
static NSString * kCIPageCurlTransition = @"CIPageCurlTransition";
static NSString * kCIPageCurlWithShadowTransition = @" ";
static NSString * kCIRippleTransition = @"CIRippleTransition";
static NSString * kCISwipeTransition = @"kCISwipeTransition";







@interface KLTFilter : CIFilter

+ (NSDictionary *)allFilter;

@end
