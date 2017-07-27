//
//  KLTImageUploaderDefine.h
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/3.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#ifndef KLTImageUploaderDefine_h
#define KLTImageUploaderDefine_h


#endif /* KLTImageUploaderDefine_h */


#define kBoundary @"----WebKitFormBoundary0IQAt0HA7oxwIx3f"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

#define DictWithJsonData(data) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


/**
 根据16进制色值及透明度返回颜色
 */
#define ColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

/**
 添加同步任务到主线程
 */
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
/**
 添加异步任务到主线程
 */
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
