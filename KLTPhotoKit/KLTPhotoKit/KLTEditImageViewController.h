//
//  KLTEditImageViewController.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/22.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTAsset.h"
@interface KLTEditImageViewController : UIViewController
//编辑成功后需要替换的Asset序号
@property(nonatomic,assign)NSUInteger  replaceIndex;

@property(nonatomic,strong)KLTAsset * sourceAsset;

@property(nonatomic,strong)void (^editSuccess)(NSUInteger replaceIndex,KLTAsset * asset);
- (void)setEditSuccess:(void (^)(NSUInteger replaceIndex, KLTAsset * asset))editSuccess;
@end
