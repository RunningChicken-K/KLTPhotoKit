//
//  UIImageView+UPLoad.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/5.
//  Copyright © 2017年 KongLT. All rights reserved.
//

@class KLTUPLoadMaskView;
#import <UIKit/UIKit.h>
#import "KLTImageUPLoader.h"


@interface UIImageView (KLTUPLoad)

@property(nonatomic,strong)KLTImageUPLoader * upLoader;


/**
 获取单张图片并把相应参数和图片上传到指定URL
 */
-  (KLTImageUPLoader *)uploadSingleImageWithUrl:(NSString *)url Prarmeters:(NSDictionary *)parameters Completion:(void (^)(NSData * data))completion;


@end
