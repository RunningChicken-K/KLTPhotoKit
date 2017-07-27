//
//  KLTRequestFormData.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/19.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#define kBoundary @"----WebKitFormBoundary0IQAt0HA7oxwIx3f"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

#import "KLTRequestFormData.h"

@implementation KLTRequestFormData


- (void)appendFileData:(NSData *)data Name:(NSString *)name
{
    // 拼接文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20151228_572.png"
     Content-Type: image/png
     空行
     文件二进制数据
     */
    [self.data appendData:[[NSString stringWithFormat:@"--%@",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.data appendData:KNewLine];
    // name="file":参数,是固定的
    // filename:文件上传到服务器以什么名字来保存,随便
    [self.data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"",name,name] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.data appendData:KNewLine];
    //Content-Type:要上传的文件的类型 (MIMEType)
    [self.data appendData: [@"Content-Type: image/jpg" dataUsingEncoding:NSUTF8StringEncoding]];
    [self.data appendData:KNewLine];
    [self.data appendData:KNewLine];
    [self.data appendData:data];
    [self.data appendData:KNewLine];
}

- (void)appendBinaryData:(NSString *)binary Name:(NSString *)name
{
    //拼接非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     非文件参数的二进制数据
     */
    [self.data appendData:[[NSString stringWithFormat:@"--%@",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.data appendData:KNewLine];
   
    [self.data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"",name] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.data appendData:KNewLine];
    [self.data appendData:KNewLine];
    [self.data appendData:[binary dataUsingEncoding:NSUTF8StringEncoding]];
    [self.data appendData:KNewLine];
}

- (void)appendFooter
{
    
    //拼接结尾标识
    /*
     --分隔符--
     */
    [self.data appendData:[[NSString stringWithFormat:@"--%@--",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSMutableData *)data
{
    if (_data == nil) {
        _data = [NSMutableData data];
    }
    return _data;
}


@end
