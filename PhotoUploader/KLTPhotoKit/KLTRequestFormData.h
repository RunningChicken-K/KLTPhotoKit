//
//  KLTRequestFormData.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/19.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLTRequestFormData : NSObject


@property(nonatomic,strong)NSMutableData * data;


/**
 添加文件参数
 */
- (void)appendFileData:(NSData *)data Name:(NSString *)name;

/**
 添加非文件参数
 */
- (void)appendBinaryData:(NSString *)binary Name:(NSString *)name;

/**
 添加尾部标识
 */
- (void)appendFooter;
@end
