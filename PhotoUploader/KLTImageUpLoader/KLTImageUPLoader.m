//
//  ImageUPLoader.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/7.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTImageUPLoader.h"

#import "KLTRequestFormData.h"

#define kBoundary @"----WebKitFormBoundary0IQAt0HA7oxwIx3f"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

#define DictWithJsonData(data) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]


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


@interface KLTImageUPLoader ()<NSURLSessionDelegate,NSURLSessionDataDelegate,KLTPhotoDelegate>

@property(nonatomic,strong)NSURLSession * session;

@property(nonatomic,strong)NSURLSessionTask * currentTask;

@end

@implementation KLTImageUPLoader


+ (instancetype)uploaderWithDidselectImage:(void (^)(UIImage * image))didSelectImage Progress:(void (^)(CGFloat progress))progress Completion:(void(^)(NSData * data,NSError * error))completion
{
    KLTImageUPLoader * uploader = [[KLTImageUPLoader alloc]init];
    
    uploader.didSelectImage = didSelectImage;
    uploader.progress = progress;
    uploader.completionHandler = completion;
    
    return uploader;
}

- (KLTPhotoTool *)photoTool
{
    if (_photoTool == nil) {
        _photoTool = [KLTPhotoTool photoTool];
        _photoTool.delegate = self;
    }
    return _photoTool;
}

- (void)uploadImage
{
    NSString * url = self.url;
    if (!url) {
        url = @"";
    }
    
    NSDictionary * parameters = self.parameters;
    if (!parameters) {
        parameters = @{};
    }
    [self uploadImageWithUrl:url Prarmaters:parameters];
}
- (NSURLSession *)session
{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        
    }
    return _session;
}
-(void)uploadImageWithUrl:(NSString *)url Prarmaters:(NSDictionary *)parameters
{

    
    __weak __typeof(self) weakself = self;
    
    [self.photoTool obtainSinglePhotoWithCompletion:^(UIImage *image) {
        if (weakself.didSelectImage) {
            
            dispatch_main_async_safe(^{
                weakself.didSelectImage(image);
            });
        }
        
        NSURL * requestUrl = [NSURL URLWithString:url];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:requestUrl];
        NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
        [request setValue:header forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"post"];

        
        NSData * formData = [weakself getBodyDataWithImageData:UIImagePNGRepresentation(image) Parameters:parameters];

        if (weakself.currentTask) {
            [weakself.currentTask cancel];
        }
        
        NSURLSessionTask * task = [weakself.session uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (weakself.completionHandler) {
                dispatch_main_async_safe(^{
                    weakself.completionHandler(data,error);
                });
                
            }
            
            if (error.code != -999) {
                //如果不是主动取消的Task  则不释放session
                [weakself.session finishTasksAndInvalidate];
                //已经invalidate的session并不会释放 此处主动设置为nil 再次调用self.session时就会创建新的可用session对象
                weakself.session = nil;
            }
           
        
            }];
        weakself.currentTask = task;
        [task resume];
        
    }];

}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    //NSLog(@"\n共%lld \n 已发送%lld\n 即将发送%lld",totalBytesExpectedToSend,totalBytesSent,bytesSent);
    if (self.progress) {
        CGFloat currentProgress = (CGFloat)totalBytesSent/totalBytesExpectedToSend;
        dispatch_main_async_safe(^{
            self.progress(currentProgress);
        });

    }
}


-(NSData *)getBodyDataWithImageData:(NSData *)data Parameters:(NSDictionary *)parameters
{
    //5.拼接数据
    KLTRequestFormData *formData = [[KLTRequestFormData alloc]init];
    
    [formData appendFileData:data Name:@"pic"];
    for (id key in parameters.allKeys) {
        [formData appendBinaryData:[parameters valueForKey:key]  Name:(NSString *)key];
    }
    [formData appendFooter];
    
    
    return formData.data;
}

- (void)didCancelPickImage
{
    if (_session) {
        [_session invalidateAndCancel];
    }
}

- (void)dealloc
{
    NSLog(@"uploader 被释放掉了");
}
@end





