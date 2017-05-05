//
//  KLTAsset.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/3.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Photos;

@interface KLTAsset : NSObject

@property(nonatomic,strong)PHAsset * asset;

@property(nonatomic,assign)BOOL  selected;
/**
 缩略图
 */
@property(nonatomic,strong)UIImage * thumbnail;
/**
 高清图  选择完成后返回的图片
 */
@property(nonatomic,strong)UIImage * HDImage;

/**
 向ImageManager请求图片资源的 RequestID,不再屏幕中显示的Requet会被取消
 */
@property(nonatomic,assign)PHImageRequestID  requestID;

@end
