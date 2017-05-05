//
//  KLTAsset.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/3.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTAsset.h"

@implementation KLTAsset

- (void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    

}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (selected) {
        if (!self.HDImage) {
            __weak __typeof(self) weakself = self;
            PHImageManager * manager = [PHImageManager defaultManager];
            PHImageRequestID requestID = [manager requestImageForAsset:self.asset targetSize:CGSizeMake(1000, 1000) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                weakself.HDImage = result;
                
            }];
        }
    }
}

@end
