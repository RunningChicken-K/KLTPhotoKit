//
//  KLTAssetCell.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/3.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTAssetCell.h"
#import "KLTAsset.h"

@interface KLTAssetCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *checkImgView;


@end

@implementation KLTAssetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//- (void)prepareForReuse
//{
//    PHImageManager * manager = [PHImageManager defaultManager];
//    [manager cancelImageRequest:_asset.requestID];
//    
//}
- (void)setAsset:(KLTAsset *)asset{
    
    _asset = asset;
    
    if (asset.thumbnail) {
        _imageView.image = asset.thumbnail;
    }
    else
    {
        PHImageManager * manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset.asset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            _imageView.image = result;
            asset.thumbnail = result;
            
        }];

    }
    
    _checkImgView.image = [UIImage imageNamed:asset.selected?@"klt_check":@"klt_uncheck"];

    
    

}
@end















