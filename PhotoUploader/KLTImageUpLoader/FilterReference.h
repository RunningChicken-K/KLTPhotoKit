//
//  FilterReference.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/17.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#ifndef FilterReference_h
#define FilterReference_h


#endif /* FilterReference_h */

#import <Foundation/Foundation.h>


#pragma mark- CICategoryBlur  模糊相关滤镜
static NSString * kCIBoxBlur = @"CIBoxBlur";//快速均值模糊
static NSString * kCIDiscBlur = @"CIDiscBlur";//环形卷积模糊
static NSString * kCIGaussianBlur = @"CIGaussianBlur";//高斯模糊
static NSString * kCIMaskedVariableBlur = @"CIMaskedVariableBlur";//提供一张图片 根据图片覆盖位置 根据提供的maskImage的灰度对源图片进行模糊 maskImg中从白到黑模糊程度递减
static NSString * kCIMedianFilter = @"CIMedianFilter";//中值模糊 用于消除图像噪点
static NSString * kCIMotionBlur = @"CIMotionBlur";//运动模糊 模拟运动过程中照到的照片
static NSString * kCINoiseReduction = @"CINoiseReduction";//降噪
static NSString * kCIZoomBlur = @"CIZoomBlur";//缩放模糊
#pragma mark- CICategoryColorAdjustment 色彩调整相关
static NSString * kCIColorClamp = @"CIColorClamp";//修改颜色到指定范围 指定值为RGBA 最小{0，0，0，0} 最大{1，1，1，1}  默认最小{0，0，0，0} 最大{1，1，1，1，1}
static NSString * kCIColorControls = @"CIColorControls";//调整图片的饱和度（默认为1），亮度和对比度（默认为1）
static NSString * kCIColorMatrix = @"CIColorMatrix";//给图片RGBA各提供一个偏移量，根据这些偏移量以及设置的基准偏移向量调整图片颜色
static NSString * kCIColorPolynomial = @"CIColorPolynomial";//通过一个三次多项式来修改图片的颜色
static NSString * kCIExposureAdjust = @"CIExposureAdjust";//调整图片的曝光设置
static NSString * kCIGammaAdjust = @"CIGammaAdjust";//伽马校正 （官方解释：Adjusts midtone brightness.  类似调整对比度？）
static NSString * kCIHueAdjust = @"CIHueAdjust";//给定一个偏移量（角度？） 取值为0-2π 0为红色 2/3π为绿色 4/3为蓝色  整体改变色彩和色调
static NSString * kCILinearToSRGBToneCurve = @"CILinearToSRGBToneCurve";//将色彩强度从线性伽马转换为sRGB色彩空间
static NSString * kCISRGBToneCurveToLinear = @"CISRGBToneCurveToLinear";//将色彩强度从sRGB空间转换为线性伽马
static NSString * kCITemperatureAndTint = @"CITemperatureAndTint";//调整温度和色彩
static NSString * kCIToneCurve = @"CIToneCurve";//通过输入的5个二维向量调整图片的R G B通道
static NSString * kCIVibrance = @"CIVibrance";//调整图像的饱和度,同时保持令人愉悦的肤色。
static NSString * kCIWhitePointAdjust = @"CIWhitePointAdjust";//以一个给定的颜色作为参考，填充白色并重新绘制其他颜色
#pragma mark- CICategoryColorEffect 色彩效果相关
static NSString * kCIColorCrossPolynomial = @"CIColorCrossPolynomial";//通过一组多项式的叉乘修改一个图像的像素值，可以用来实现颜色的映射转换（例如把红花变黄花）
static NSString * kCIColorCube = @"CIColorCube";//使用一个三维色值表 对图片颜色进行处理
static NSString * kCIColorCubeWithColorSpace = @"CIColorCubeWithColorSpace";//使用一个三维色值表  将图片渲染为指定的色彩空间下的颜色
static NSString * kCIColorInvert = @"CIColorInvert";//反转图片的颜色
static NSString * kCIColorMap = @"CIColorMap";//通过提供的另一张图片中的颜色映射  改变源图片的颜色
static NSString * kCIColorMonochrome = @"CIColorMonochrome";//设定某一颜色的强度，然后按照该值对图片颜色重新做映射
static NSString * kCIColorPosterize = @"CIColorPosterize";//设置一个分别用于RGB的亮度的值
static NSString * kCIFalseColor = @"CIFalseColor";//两种颜色的亮度映射到一个颜色渐变。 常用语处理天文图片和X光紫外线等
static NSString * kCIMaskToAlpha = @"CIMaskToAlpha";//根据像素的灰度做透明处理  白色将会被完全保留  黑色将会变为全透明
static NSString * kCIMaximumComponent = @"CIMaximumComponent";//取每个像素RGB中的最大值制作灰度图片  即将每个像素的RGB三个值都替换为三者中最大的值
static NSString * kCIMinimumComponent = @"CIMinimumComponent";//取每个像素RGB中的最小值制作灰度图片  即将每个像素的RGB三个值都替换为三者中最小的值
static NSString * kCIPhotoEffectChrome = @"CIPhotoEffectChrome";//古典(高对比度)效果滤镜
static NSString * kCIPhotoEffectFade = @"CIPhotoEffectFade";//古典(低对比度)效果滤镜
static NSString * kCIPhotoEffectInstant = @"CIPhotoEffectInstant";//发黄老照片效果
static NSString * kCIPhotoEffectMono = @"CIPhotoEffectMono";//黑白(低对比度)照片滤镜
static NSString * kCIPhotoEffectNoir = @"CIPhotoEffectNoir";//黑白(高对比度)照片滤镜
static NSString * kCIPhotoEffectProcess = @"CIPhotoEffectProcess";//冷色调滤镜
static NSString * kCIPhotoEffectTonal = @"CIPhotoEffectTonal";//黑白(未调整对比度)照片效果
static NSString * kCIPhotoEffectTransfer = @"CIPhotoEffectTransfer";//暖色调滤镜
static NSString * kCISepiaTone = @"CISepiaTone";//根据给定的值将照片绘制为不同程度的棕色
static NSString * kCIVignette = @"CIVignette";//根据参数减少图片边缘的亮度
static NSString * kCIVignetteEffect = @"CIVignetteEffect";//根据参数给修改图片指定区域之外的亮度
#pragma mark- CICategoryCompositeOperation 混合复合操作(图片合成，输入参数为源图片和一张背景图片，采集背景图片的某些属性如亮度，色调等然后合成到源图片上)
static NSString * kCIAdditionCompositing = @"CIAdditionCompositing";//提供源图片和另一张背景图用来实现高亮和光晕效果
static NSString * kCIColorBlendMode = @"CIColorBlendMode";//使用背景图片的亮度 使用源图片的色调和饱和度
static NSString * kCIColorBurnBlendMode = @"CIColorBurnBlendMode";//使用暗色的背景图片，映射源图片
static NSString * kCIColorDodgeBlendMode = @"CIColorDodgeBlendMode";//提高背景图片的亮度，然后合成到源图片
static NSString * kCIDarkenBlendMode = @"CIDarkenBlendMode";//从背景图片或者源图片中选择较暗的一个用于合成
static NSString * kCIDifferenceBlendMode = @"CIDifferenceBlendMode";//取两个图片亮度的差值
static NSString * kCIDivideBlendMode = @"CIDivideBlendMode";//将背景图频的颜色映射到源图片上
static NSString * kCIExclusionBlendMode = @"CIExclusionBlendMode";//产生类似CIDivideBlendMode的效果，但是对比度更低
static NSString * kCIHardLightBlendMode = @"CIHardLightBlendMode";//如果源图像样本颜色比50%灰色轻,背景变亮了,类似于筛选。如果源图像样本颜色比50%灰色暗,背景是黑暗的,类似于相乘。如果源图像样本颜色灰色= 50%,源图像是没有改变。图像样本,等于纯黑色或纯白色的纯黑色或白色。整体效果类似于你将达到光辉的源图像置于聚光灯下
static NSString * kCIHueBlendMode = @"CIHueBlendMode";//使用背景图的亮度和饱和度 使用源图片的色调
static NSString * kCILightenBlendMode = @"CILightenBlendMode";//从背景图片或者源图片中选择较亮的一个用于合成
static NSString * kCILinearBurnBlendMode = @"CILinearBurnBlendMode";//使背景图像样本变暗以反映源图像样本，同时也增加对比度。此过滤器的效果与CIColorBurnBlendMode过滤器的效果相似，但更为显著
static NSString * kCILinearDodgeBlendMode = @"CILinearDodgeBlendMode";//增强背景图像样本以反映源图像样本，同时也增加对比度。此过滤器的效果与CIColorDodgeBlendMode过滤器的效果相似，但更为显著。
static NSString * kCILuminosityBlendMode = @"CILuminosityBlendMode";//使用背景图像的色调和饱和度与输入图像的亮度。 此模式会产生与CIColorBlendMode过滤器创建的效果相反的效果。
static NSString * kCIMaximumCompositing = @"CIMaximumCompositing";//通过颜色分量计算两个输入图像的最大值，并使用最大值创建输出图像。
static NSString * kCIMinimumCompositing = @"CIMinimumCompositing";//通过颜色分量计算两个输入图像的最小值，并使用最小值创建输出图像。
static NSString * kCIMultiplyBlendMode = @"CIMultiplyBlendMode";//将输入图像样本与背景图像样本相乘。
static NSString * kCIMultiplyCompositing = @"CIMultiplyCompositing";//乘以两个输入图像的颜色分量，并使用相乘的值创建输出图像。

static NSString * kCIOverlayBlendMode = @"CIOverlayBlendMode";//根据背景颜色，将输入图像样本与背景图像样本相乘或遮挡
static NSString * kCIPinLightBlendMode = @"CIPinLightBlendMode";//根据源图像样本的亮度，根据源图像样本有条件地替换背景图像样本
static NSString * kCISaturationBlendMode = @"CISaturationBlendMode";//使用输入图像饱和度的背景图像的亮度和色调值,没有饱和背景的区域（即纯灰色区域）不会产生变化
static NSString * kCIScreenBlendMode = @"CIScreenBlendMode";//将输入图像样本的倒数乘以背景图像样本的倒数,这导致颜色至少与两种样品颜色中的任一种一样轻
static NSString * kCISoftLightBlendMode = @"CISoftLightBlendMode";//根据输入图像样品颜色，变暗或减淡颜色。
static NSString * kCISourceAtopCompositing = @"CISourceAtopCompositing";//将输入图像放置在背景图像上，然后使用背景图像的亮度来确定要显示的内容。
static NSString * kCISourceInCompositing = @"CISourceInCompositing";//使用背景图像来定义输入图像中要留下的内容，有效地裁剪输入图像。
static NSString * kCISourceOutCompositing = @"CISourceOutCompositing";//使用背景图像来定义要从输入图像中取出的内容。
static NSString * kCISourceOverCompositing = @"CISourceOverCompositing";//将输入图像放置在输入的背景图像上。
static NSString * kCISubtractBlendMode = @"CISubtractBlendMode";//从源图像样本颜色中减去背景图像样本颜色。
#pragma mark- CICategoryDistortionEffect (变形效果)
static NSString * kCIBumpDistortion = @"CIBumpDistortion";//创建起始于图像中指定点的凸起。 可以向内凸起（凹）或向外凸起
static NSString * kCIBumpDistortionLinear = @"CIBumpDistortionLinear";//创建源自图像中的一条线的凹凸失真。
static NSString * kCICircleSplashDistortion = @"CICircleSplashDistortion";//使像素从圆周的圆周开始扭曲，向外发出。
static NSString * kCICircularWrap = @"CICircularWrap";//使图像包围一个透明圆圈。
static NSString * kCIDroste = @"CIDroste";//以模仿M. C. Escher绘图的方式递归绘制图像的一部分。
static NSString * kCIDisplacementDistortion = @"CIDisplacementDistortion";//将第二个图像的灰度值应用于第一个图像。
static NSString * kCIGlassDistortion = @"CIGlassDistortion";//通过应用玻璃状纹理扭曲图像。
static NSString * kCIGlassLozenge = @"CIGlassLozenge";//创建一个菱形透镜，并扭曲放置镜头的图像部分。
static NSString * kCIHoleDistortion = @"CIHoleDistortion";//创建一个圆形区域，将图像像素向外推，使最接近圆圈的像素失真。
static NSString * kCILightTunnel = @"CILightTunnel";//旋转由中心和半径参数指定的输入图像的一部分，以产生隧道效应。
static NSString * kCIPinchDistortion = @"CIPinchDistortion";//创建一个矩形区域，向内夹住源像素，使最接近矩形的像素失真。
static NSString * kCIStretchCrop = @"CIStretchCrop";//通过拉伸和裁剪图像以适应目标尺寸来扭曲图像。
static NSString * kCITorusLensDistortion= @"CITorusLensDistortion";//创建一个圆环形透镜，并扭曲放置镜头的图像部分。
static NSString * kCITwirlDistortion = @"CITwirlDistortion";//旋转点周围的像素以产生旋转效果。
static NSString * kCIVortexDistortion = @"CIVortexDistortion";//旋转点周围的像素以模拟涡流。

#pragma mark- CICategoryGenerator 效果生成器（该类过滤器均不需要输入源图像，而是根据输入的颜色，坐标等参数直接产生相应结果）
static NSString * kCIAztecCodeGenerator = @"CIAztecCodeGenerator";//二维码生成器（Azetc二维码）
static NSString * kCICheckerboardGenerator = @"CICheckerboardGenerator";//生成一个类似棋盘的黑白（也可以是其他颜色）交接的图片 可以自定义尺寸和锐度
static NSString * kCICode128BarcodeGenerator = @"CICode128BarcodeGenerator";//生成条形码
static NSString * kCIConstantColorGenerator = @"CIConstantColorGenerator";//产生一块纯色区域
static NSString * kCILenticularHaloGenerator = @"CILenticularHaloGenerator";//模拟镜头光晕。
static NSString * kCIPDF417BarcodeGenerator = @"CIPDF417BarcodeGenerator";//从输入数据生成PDF417代码（二维条形码）
static NSString * kCIQRCodeGenerator = @"CIQRCodeGenerator";//从输入数据生成快速响应代码（QR二维条）
static NSString * kCIRandomGenerator = @"CIRandomGenerator";//生成无限长度的图像，其像素值由0到1范围内的四个独立，均匀分布的随机数组成。 即生成一张噪点图像
static NSString * kCIStarShineGenerator = @"CIStarShineGenerator";//产生类似于超新星的星爆模式;可用于模拟镜头闪光。
static NSString * kCIStripesGenerator = @"CIStripesGenerator";//生成条纹图案。

static NSString * kCISunbeamsGenerator = @"CISunbeamsGenerator";//产生阳光照射效果。

#pragma mark- CICategoryGeometryAdjustment 几何调整
static NSString * kCIAffineTransform = @"CIAffineTransform";//对图像应用仿射变换。
/*
 
 CGAffineTransform xfrom;
 [myFilter setValue:[NSValue valueWithBytes:&xform
 objCType:@encode(CGAffineTransform)]
 forKey:@"inputTransform"];
 
 */
static NSString * kCICrop = @"CICrop";//给定一个矩形将剪裁图片
static NSString * kCILanczosScaleTransform = @"CILanczosScaleTransform";//生成源图像的高质量缩放版本。
static NSString * kCIPerspectiveCorrection = @"CIPerspectiveCorrection";//应用透视校正，将源图像中的任意四边形区域变换为矩形输出图像。
static NSString * kCIPerspectiveTransform = @"CIPerspectiveTransform";//改变图像的几何形状，以模拟观察者改变观看位置的效果。

static NSString * kCIPerspectiveTransformWithExtent = @"CIPerspectiveTransformWithExtent";//在指定范围内改变图像的几何形状，以模拟观察者改变观看位置的效果。
static NSString * kCIStraightenFilter = @"CIStraightenFilter";//以弧度旋转指定角度的源图像。
#pragma mark- CICategoryGradient
static NSString * kCIGaussianGradient = @"CIGaussianGradient";//使用高斯分布生成从一种颜色变化到另一种颜色的渐变。
static NSString * kCILinearGradient = @"CILinearGradient";//生成沿两个定义的端点之间的线性轴变化的梯度。
static NSString * kCIRadialGradient = @"CIRadialGradient";//产生在具有相同中心的两个圆之间径向变化的梯度。
static NSString * kCISmoothLinearGradient = @"CISmoothLinearGradient";//生成一个渐变，使用S曲线函数在两个定义的端点之间沿着线性轴混合颜色。

#pragma mark- CICategoryHalftoneEffect 半色调效果
static NSString * kCICircularScreen = @"CICircularScreen";//模拟圆形半色调屏幕。
static NSString * kCICMYKHalftone = @"CICMYKHalftone";//使用青色，品红色，黄色和黑色墨水在白页上创建源图像的颜色，半色调的再现。
static NSString * kCIDotScreen = @"CIDotScreen";//模拟半色调屏幕的点图案。
static NSString * kCIHatchedScreen = @"CIHatchedScreen";//模拟半色调屏幕的阴影图案。
static NSString * kCILineScreen = @"CILineScreen";//模拟半色调屏幕的线条图案。
#pragma mark- CICategoryReduction 取色
static NSString * kCIAreaAverage = @"CIAreaAverage";//返回包含感兴趣区域的平均颜色的单像素图​​像。
static NSString * kCIAreaHistogram  = @"CIAreaHistogram";//返回包含为指定矩形区域计算的分量直方图的1D图像（inputCount宽一个像素高）。
static NSString * kCIRowAverage = @"CIRowAverage";//返回包含每个扫描行的平均颜色的1像素高图像。
static NSString * kCIColumnAverage = @"CIColumnAverage";//返回包含每个扫描列的平均颜色的1像素高图像。
static NSString * kCIHistogramDisplayFilter = @"CIHistogramDisplayFilter";//从CIAreaHistogram过滤器的输出生成直方图图像。
static NSString * kCIAreaMaximum = @"CIAreaMaximum";//返回包含感兴趣区域的最大颜色分量的单像素图​​像。
static NSString * kCIAreaMinimum = @"CIAreaMinimum";//返回包含感兴趣区域的最小颜色分量的单像素图​​像。
static NSString * kCIAreaMaximumAlpha = @"CIAreaMaximumAlpha";//返回包含感兴趣区域的最大alpha值的颜色向量的单像素图​​像。
static NSString * kCIAreaMinimumAlpha = @"CIAreaMinimumAlpha";//返回包含感兴趣区域的最小alpha值的颜色向量的单像素图​​像。
#pragma mark- CICategorySharpen 锐化
static NSString * kCISharpenLuminance = @"CISharpenLuminance";//通过锐化增加图像细节。
static NSString * kCIUnsharpMask = @"CIUnsharpMask";//增加图像中不同颜色的像素之间的边缘的对比度。
#pragma mark- CICategoryStylize 风格化滤镜
static NSString * kCIBlendWithAlphaMask = @"CIBlendWithAlphaMask";//使用蒙版的alpha值在图像和背景之间进行插值。
static NSString * kCIBlendWithMask = @"CIBlendWithMask";//使用灰度蒙版的值在图像和背景之间进行插值。
static NSString * kCIBloom = @"CIBloom";//软化边缘，并向图像施加愉快的光芒。
static NSString * kCIComicEffect = @"CIComicEffect";//通过概述边缘并应用彩色半色调效果来模拟漫画图画。
static NSString * kCIConvolution3X3 = @"CIConvolution3X3";//通过执行3x3矩阵卷积来修改像素值。
static NSString * kCIConvolution5X5 = @"CIConvolution5X5";//通过执行5x5矩阵卷积来修改像素值。
static NSString * kCIConvolution7X7 = @"CIConvolution7X7";//通过执行7x7矩阵卷积来修改像素值。
static NSString * kCIConvolution9Horizontal = @"CIConvolution9Horizontal";//通过执行9元素水平卷积来修改像素值。
static NSString * kCIConvolution9Vertical = @"CIConvolution9Vertical";//通过执行9元素竖直卷积来修改像素值。
static NSString * kCICrystallize = @"CICrystallize";//通过聚合源像素颜色值创建多边形颜色块。(马赛克)

static NSString * kCIDepthOfField = @"CIDepthOfField";//景深效果 虚化背景和边缘等
static NSString * kCIEdges = @"CIEdges";//查找图像中的所有边缘并以彩色显示。
static NSString * kCIEdgeWork = @"CIEdgeWork";//生成一个风格化的黑白渲染的图像，看起来类似于木块切口。
static NSString * kCIGloom = @"CIGloom";//使图像的亮点消失。
static NSString * kCIHeightFieldFromMask = @"CIHeightFieldFromMask";//从灰度掩模产生连续的三维，高角形高度场。掩码的白色值定义了高度域内的像素，而黑色值定义了外部的像素。该面罩在面罩内平滑连续地变化，达到面罩边缘的值0。您可以将此过滤器与CIShadedMaterial过滤器一起使用来生成非常逼真的阴影对象

static NSString * kCIHexagonalPixellate = @"CIHexagonalPixellate";//将图像映射到彩色六边形，其颜色由替换的像素定义。

static NSString * kCIHighlightShadowAdjust = @"CIHighlightShadowAdjust";//调整图像的色调映射，同时保留空间细节。

static NSString * kCILineOverlay = @"CILineOverlay";//创建一个草图，勾勒出黑色图像的边缘。
static NSString * kCIPixellate = @"CIPixellate";//通过将图像映射到由替换的像素定义其颜色的彩色正方形，使图像块化。马赛克
static NSString * kCIPointillize = @"CIPointillize";//以点样式呈现源图像。
static NSString * kCIShadedMaterial = @"CIShadedMaterial";//从高度字段生成阴影图像。高度场被定义为具有较高的高度，较浅的色调，较低的高度（较低的区域）具有较暗的色调。您可以将此过滤器与CIHeightFieldFromMask过滤器相结合，以生成掩码（如文本）的快速阴影。 该过滤器将输入图像设置为高度场（乘以比例参数），并计算每个像素的法向量。然后使用该法向量在输入阴影图像中查找该方向的反射颜色。 输入阴影图像包含半球的图片，其定义了表面被遮蔽的方式。法向量的查找坐标为： （normal.xy + 1.0）* 0.5 * vec2（shadingImageWidth，shadingImageHeight）

static NSString * kCISpotColor = @"CISpotColor";//用专色替换一个或多个颜色范围。
static NSString * kCISpotLight = @"CISpotLight";//对图像应用定向聚光灯效果。

#pragma mark- CICategoryTileEffect 瓷砖/拼接效果 （iOS 9 Later）
static NSString * kCIAffineClamp = @"CIAffineClamp";//在源图像上执行仿射变换，然后夹紧转换图像边缘处的像素，将其向外延伸。
static NSString * kCIAffineTile = @"CIAffineTile";//对图像应用仿射变换，然后平铺转换的图像。
static NSString * kCIEightfoldReflectedTile = @"CIEightfoldReflectedTile";//通过应用8路反射对称性从源图像生成平铺图像。
static NSString * kCIFourfoldReflectedTile = @"CIFourfoldReflectedTile";//通过应用4向反射对称性从源图像生成平铺图像。
static NSString * kCIFourfoldRotatedTile = @"CIFourfoldRotatedTile";//通过以90度的增量旋转源图像，从源图像生成平铺图像。
static NSString * kCIFourfoldTranslatedTile = @"CIFourfoldTranslatedTile";//通过应用4个变换操作从源图像生成平铺图像。
static NSString * kCIGlideReflectedTile = @"CIGlideReflectedTile";//通过变换和涂抹图像，从源图像生成平铺图像。
static NSString * kCIKaleidoscope = @"CIKaleidoscope";//通过应用12路对称性从源图像生成万花筒图像。
static NSString * kCIOpTile = @"CIOpTile";//分割图像，应用任何指定的缩放和旋转，然后再次组合图像以给出操作艺术外观。
static NSString * kCIParallelogramTile = @"CIParallelogramTile";//通过以平行四边形反射来扭曲图像，然后平铺结果。
static NSString * kCIPerspectiveTile = @"CIPerspectiveTile";//将透视变换应用于图像，然后平铺结果。
static NSString * kCISixfoldReflectedTile = @"CISixfoldReflectedTile";//通过应用6路反射对称性从源图像生成平铺图像。
static NSString * kCISixfoldRotatedTile = @"CISixfoldRotatedTile";//通过以60度为增量旋转源图像，从源图像生成平铺图像。
static NSString * kCITriangleKaleidoscope = @"CITriangleKaleidoscope";//绘制输入图像的三角形部分以创建万花筒效果。
static NSString * kCITriangleTile = @"CITriangleTile";//将图像的三角形部分映射到三角形区域，然后平铺结果。
static NSString * kCITwelvefoldReflectedTile = @"CITwelvefoldReflectedTile";//通过以30度为增量旋转源图像，从源图像生成平铺图像。

#pragma mark- CICategoryTransition 转场效果
static NSString * kCIAccordionFoldTransition = @"CIAccordionFoldTransition";//通过展开和交叉渐变从一个图像到不同维度的另一个图像。
static NSString * kCIBarsSwipeTransition = @"CIBarsSwipeTransition";//通过在源图像上传递一个图像，从一个图像转换到另一个图像。
static NSString * kCICopyMachineTransition = @"CICopyMachineTransition";//通过模拟复印机的效果，从一幅图像转换到另一幅图像。
static NSString * kCIDisintegrateWithMaskTransition = @"CIDisintegrateWithMaskTransition";//使用掩码定义的形状从一个图像转换到另一个图像。
static NSString * kCIDissolveTransition = @"CIDissolveTransition";//使用溶解从一个图像转换到另一个图像。
static NSString * kCIFlashTransition = @"CIFlashTransition";//通过创建闪光灯从一个图像转换到另一个图像。
static NSString * kCIModTransition = @"CIModTransition";//通过不规则形状的孔露出目标图像，从一个图像转换到另一个图像。
static NSString * kCIPageCurlTransition = @"CIPageCurlTransition";//通过模拟卷曲页面，从一幅图像转换到另一幅图像，在页面卷曲时显示新图像。
static NSString * kCIPageCurlWithShadowTransition = @"PageCurlWithShadowTransition";//通过模拟卷曲页面，从一幅图像转换到另一幅图像，在页面卷曲时显示新图像。（翻页效果）
static NSString * kCIRippleTransition = @"CIRippleTransition";//通过创建从中心点扩展的圆形波形，从一幅图像转换到另一幅图像，在波形之后显示新图像。
static NSString * kCISwipeTransition = @"kCISwipeTransition";//通过模拟滑动动作从一个图像转换到另一个图像。
