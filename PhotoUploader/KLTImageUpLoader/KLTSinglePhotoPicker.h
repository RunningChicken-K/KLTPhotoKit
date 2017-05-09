//
//  PhotoTool.h
//  ChongZu
//
//  Created by 孔令涛 on 2017/3/30.
//  Copyright © 2017年 cz10000. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,PhotoSource) {
    
    PhotoSourceFromCameraAndAlbum,
    PhotoSourceFromCamera,
    PhotoSourceFromAlbum,
    
};

@protocol KLTSinglePhotoPickerDelegate <NSObject>
@required
- (void)didCancelPickImage;

@end

@interface KLTSinglePhotoPicker : NSObject


@property(nonatomic,weak)id<KLTSinglePhotoPickerDelegate> delegate;


/**
 照片来源 默认是相机和相册，此时会弹出AlertController询问选择相机还是相册
 */
@property(nonatomic,assign)PhotoSource  photoSource;

/**
 当照片来源是相册和相机时 弹出的AlertController的标题
 */
@property(nonatomic,copy)NSString * alertTitle;
/**
 当照片来源是相机和相册时 弹出的AlertController的message
 */
@property(nonatomic,copy)NSString * alertMessage;
/**
 选取完照片之后是否允许编辑 默认YES
 */
@property(nonatomic,assign)BOOL  allowEditing;

/**
 选取后剪裁的尺寸  默认不裁剪图片 如果设置了此参数 则按照给定的尺寸裁剪
*/
@property(nonatomic,assign)CGSize  scaleSize;

/**
 压缩比率  默认不对图片做压缩处理    如果设置此参数  则会将图片转化为JPG格式  并按照给定的压缩比率进行压缩
 */
@property(nonatomic,assign)CGFloat  CompressRate;




+ (instancetype)photoTool;


/**
 获取单张图片图片
 */
- (void)obtainSinglePhotoWithCompletion:(void (^)(UIImage * image))completion;
@end















