//
//  ImageUPLoader.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/7.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTImageUPLoader.h"

#import "KLTRequestFormData.h"

#import "KLTImageUploaderDefine.h"




@interface KLTImageUPLoader ()<NSURLSessionDelegate,NSURLSessionDataDelegate,KLTSinglePhotoPickerDelegate>

/**
 更新进度时的回调
 */
@property(nonatomic,strong)void (^progress)(CGFloat progress);
/**
 使用相机或者相册获取到图片后的回调
 */
@property(nonatomic,strong)void (^didSelectImage)(UIImage * image);
/**
 上传完成后的回调方法
 */
@property(nonatomic,strong)void (^completionHandler)(NSData *  data, NSError * error);


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

- (KLTSinglePhotoPicker *)photoTool
{
    if (_photoTool == nil) {
        _photoTool = [KLTSinglePhotoPicker photoTool];
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

        [weakself uploadWithFormRequest:request Data:formData];
        
    }];

}

- (void)uploadImages:(NSDictionary *)images Url:(NSString *)url Parameters:(NSDictionary *)parameters Progress:(void (^)(CGFloat))progress Completion:(void (^)(NSData *, NSError *))completion
{
   
    if (!url) {
        url = @"";
    }
    if (!parameters) {
        parameters = @{};
    }
    self.completionHandler = completion;

    NSURL * requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:requestUrl];
    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"post"];
    
    NSData * formData = [self getBodyDataWithImages:images Parameters:parameters];
    [self uploadWithFormRequest:request Data:formData];
    
}
- (void)uploadWithFormRequest:(NSURLRequest *)request Data:(NSData *)formData
{
     __weak __typeof(self) weakself = self;
    if (self.currentTask) {
        [self.currentTask cancel];
    }
    NSURLSessionTask * task = [self.session uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (self.completionHandler) {
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
    self.currentTask = task;
    [task resume];

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

-(NSData *)getBodyDataWithImages:(NSDictionary *)images Parameters:(NSDictionary *)parameters
{
    KLTRequestFormData *formData = [[KLTRequestFormData alloc]init];
    [images enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [formData appendFileData:UIImagePNGRepresentation(obj) Name:key];
    }];

    for (id key in parameters.allKeys) {
        [formData appendBinaryData:[parameters valueForKey:key]  Name:(NSString *)key];
    }
    [formData appendFooter];
    return  formData.data;
    
}

-(NSData *)getBodyDataWithImageData:(NSData *)data Parameters:(NSDictionary *)parameters
{
    //拼接数据
    KLTRequestFormData *formData = [[KLTRequestFormData alloc]init];
    if (!_fileName) {
        NSLog(@"没有fileName！");
    }
    [formData appendFileData:data Name:self.fileName];
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





