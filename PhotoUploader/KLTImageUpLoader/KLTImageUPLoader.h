//
//  ImageUPLoader.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/7.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTSinglePhotoPicker.h"
@interface KLTImageUPLoader : NSObject

@property(nonatomic,copy)NSString * url;

@property(nonatomic,copy)NSDictionary * parameters;

@property(nonatomic,copy)NSString * fileName;


/**
 图片获取工具   通过photo.sourceType等对图片获取或剪裁进行设置
 */
@property(nonatomic,strong)KLTSinglePhotoPicker * photoTool;




+ (instancetype)uploaderWithDidselectImage:(void (^)(UIImage * image))didSelectImage Progress:(void (^)(CGFloat progress))progress Completion:(void(^)(NSData * data,NSError * error))completion;

- (void)uploadImage;

//-(void)uploadImageWithUrl:(NSString *)url Prarmaters:(NSDictionary *)parameters;

@end
