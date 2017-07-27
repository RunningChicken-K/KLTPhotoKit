//
//  KLTPhotoKit.m
//  PhotoUploader
//
//  Created by CZ10000 on 2017/7/25.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTPhotoKit.h"
#import "KLTAlbumPhotoList.h"
#import "KLTPhotoNavController.h"
#import "KLTImageUPLoader.h"
@implementation KLTPhotoKit

+ (void)singlePhotoWithSource:(PhotoSource)photoSource alertTitle:(NSString *)title alertMessage:(NSString *)msg AllEdit:(BOOL)edited ScaleSize:(CGSize)scaleSize CompressRate:(CGFloat)compressRate Completion:(void (^)(UIImage * image))completion
{
    KLTSinglePhotoPicker * picker = [KLTSinglePhotoPicker photoTool];
    picker.photoSource = photoSource;
    picker.alertTitle = title;
    picker.alertMessage = msg;
    picker.allowEditing = edited;
    picker.scaleSize = scaleSize;
    picker.CompressRate = compressRate;
    [picker obtainSinglePhotoWithCompletion:completion];
}

+ (void)multiPhotosWithTargetSize:(CGSize)size Completion:(void (^)(NSArray * imagesArray))completion
{
    KLTAlbumPhotoList * al = [[KLTAlbumPhotoList alloc]init];
    al.targetSize = size;
    [al setDidSelectImages:completion];
    KLTPhotoNavController * kvc = [[KLTPhotoNavController alloc]initWithRootViewController:al];
    
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:kvc animated:YES completion:nil];
}

+ (void)uploadImages:(NSDictionary *)images Url:(NSString *)url Parameters:(NSDictionary *)parameters Progress:(void (^)(CGFloat))progress Completion:(void (^)(NSData *, NSError *))completion
{
    
    KLTImageUPLoader * uploader = [[KLTImageUPLoader alloc]init];
    [uploader uploadImages:images Url:url Parameters:parameters Progress:progress Completion:completion];
}

@end
