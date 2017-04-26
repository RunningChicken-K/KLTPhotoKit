//
//  UIImageView+UPLoad.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/5.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "UIImageView+KLTUPLoad.h"
#import "KLTUPLoadMaskView.h"
#import <objc/runtime.h>

static char key;

@implementation UIImageView (KLTUPLoad)

- (KLTImageUPLoader *)upLoader
{
    return objc_getAssociatedObject(self, &key);
}

- (void)setUpLoader:(KLTImageUPLoader *)upLoader
{
    objc_setAssociatedObject(self, &key, upLoader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (KLTImageUPLoader *)uploadSingleImageWithUrl:(NSString *)url Prarmeters:(NSDictionary *)parameters Completion:(void (^)(NSData * data,UIImageView * imageView))completion
{
//    for (UIView * subView in  self.subviews) {
//        if ([subView isKindOfClass:[KLTUPLoadMaskView class]]) {
//            [subView removeFromSuperview];
//        }
//    }
    
    __block KLTUPLoadMaskView * maskView = [[KLTUPLoadMaskView alloc]initWithFrame:self.bounds];
   // NSLog(@"uploader is %@",self.upLoader);
    
    if (!self.upLoader) {
        __weak __typeof(self) weakself = self;
        self.upLoader = [KLTImageUPLoader uploaderWithDidselectImage:^(UIImage *image) {
            
            weakself.image = image;
            [weakself addSubview:maskView];
            
        } Progress:^(CGFloat progress) {
            
            if (progress >= 1) {
                maskView.progress = @"99.99%";
            }
            else
            {
                NSString * pro = [NSString stringWithFormat:@"%.2f%@",progress * 100,@"%"];
                
                [maskView setProgress:pro];
                
            }
            
            
            
        } Completion:^(NSData *data, NSError *error) {
            
            if (!error) {
                if (maskView) {
                    [maskView removeFromSuperview];
                }
                if (completion) {
                    completion(data,weakself);
                }
            }
            else{
                NSLog(@"%@",error);
                if (error.code == -999) {
                    maskView.progress = @"取消上传";
                }
                else{
                    maskView.progress = @"上传失败";
                }
                
            }
            
            
        }];
    }
    self.upLoader.url = url;
    self.upLoader.parameters = parameters;
   
    
    //[self.upLoader uploadImageWithUrl:url Prarmaters:parameters];
    return self.upLoader;
}
@end
