//
//  KLTAlbumPhotoList.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/26.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KLTAlbumPhotoList : UIViewController


@property(nonatomic,strong) void (^didSelectImages)(NSArray * imagesArray);

- (void)setDidSelectImages:(void (^)(NSArray * imagesArray))didSelectImages;

/**
目标尺寸    此尺寸是个估值  不影响实际返回图片的尺寸和比例
默认返回原图
 */
@property(nonatomic,assign)CGSize  targetSize;

@end
