//
//  ImageUPLoader.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/7.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTPhotoTool.h"
@interface KLTImageUPLoader : NSObject

@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSDictionary * parameters;

/**
 图片获取工具   通过photo.sourceType等对图片获取或剪裁进行设置
 */
@property(nonatomic,strong)KLTPhotoTool * photoTool;

/**
 更新进度时的回调
 */
@property(nonatomic,strong)void (^progress)(CGFloat progress);
/**
 使用相机或者相册获取到图片后的回调
 */
@property(nonatomic,strong)void (^didSelectImage)(UIImage * image);
/**
 上传完成后的回调方法
 */
@property(nonatomic,strong)void (^completionHandler)(NSData *  data, NSError * error);


+ (instancetype)uploaderWithDidselectImage:(void (^)(UIImage * image))didSelectImage Progress:(void (^)(CGFloat progress))progress Completion:(void(^)(NSData * data,NSError * error))completion;

- (void)uploadImage;

//-(void)uploadImageWithUrl:(NSString *)url Prarmaters:(NSDictionary *)parameters;

@end
