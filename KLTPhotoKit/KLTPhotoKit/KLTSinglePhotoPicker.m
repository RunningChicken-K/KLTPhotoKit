//
//  PhotoTool.m
//  ChongZu
//
//  Created by 孔令涛 on 2017/3/30.
//  Copyright © 2017年 cz10000. All rights reserved.
//

#import "KLTSinglePhotoPicker.h"


@interface KLTSinglePhotoPicker()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)void (^completion)(UIImage * image);



@end

@implementation KLTSinglePhotoPicker
+ (instancetype)photoTool
{
    return [[KLTSinglePhotoPicker alloc]init];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allowEditing = YES;
//        self.alertTitle = @"选择照片来源";
//        self.alertMessage = @"选择照片来源";
        
        
    }
    return self;
}

- (void)obtainSinglePhotoWithCompletion:(void (^)(UIImage *))completion
{
    self.completion = completion;
    
    [self configPhotoSource];
}
- (void)configPhotoSource
{
    
    switch (self.photoSource) {
        case PhotoSourceFromCameraAndAlbum:
            [self pickPhotoSource];
            break;
        case PhotoSourceFromAlbum:
            [self obtainPhotoFromAlbum];
            break;
            
        case PhotoSourceFromCamera:
            [self obtainPhotoFromCamera];
            break;
        default:
            break;
    }
    
    
}

- (void)pickPhotoSource
{
    
    UIViewController * currentVC = [self currentViewController];
    
#ifdef __IPHONE_8_0
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:self.alertTitle message:self.alertMessage preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //[alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self obtainPhotoFromAlbum];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self obtainPhotoFromCamera];
    }]];
    [currentVC presentViewController:alert animated:YES completion:nil];
#else
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:self.alertTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    [sheet addButtonWithTitle:@"相册"];
    [sheet addButtonWithTitle:@"相机"];
    [sheet showInView:currentVC.view];

#endif
    
    


}
/**
 从系统相册获取照片
 */
- (void)obtainPhotoFromAlbum
{
    
    //手动 retain  防止提前释放
    CFRetain((__bridge CFTypeRef)(self));
    UIViewController * currentVC = [self currentViewController];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.allowEditing;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [currentVC presentViewController:imagePicker animated:YES completion:nil];
}
/**
 从相机获取照片
 */
- (void)obtainPhotoFromCamera
{
    //手动retain 防止提前释放
    CFRetain((__bridge CFTypeRef)(self));
    UIViewController * currentVC = [self currentViewController];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.allowEditing;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [currentVC presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark- ImagePickerViewController Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //前面手动retain 这里手动release
    CFRelease((__bridge CFTypeRef)(self));
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.delegate didCancelPickImage];
    }];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //前面手动retain  这里手动release
    CFRelease((__bridge CFTypeRef)(self));
      __block UIImage *img = self.allowEditing? [info objectForKey:UIImagePickerControllerEditedImage]:[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.completion) {
            
            if (self.scaleSize.height != 0 && self.scaleSize.width != 0) {
                img = [self thumbnailWithImageWithoutScale:img size:self.scaleSize];
            }
            if (self.CompressRate >= 0.00) {
                img = [UIImage imageWithData:UIImageJPEGRepresentation(img, self.CompressRate)];
            }
            
            self.completion(img);
        }
    }];

    
}



#pragma mark- SheetAction Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self obtainPhotoFromAlbum];
    }
    if (buttonIndex == 1) {
        [self obtainPhotoFromCamera];
    }
}

- (UIViewController *)currentViewController
{
    UINavigationController *nav = nil;
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        nav = (UINavigationController *)vc;

    }
    else
    {
        return vc;
    }

    return nav;
}

/**
 保证图片比例不变的情况下 将图片拉伸为给定尺寸的缩略图
 */

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)newSize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (newSize.width/oldsize.width > newSize.height/oldsize.height) {
            rect.size.width = oldsize.width*(newSize.height/oldsize.height);
            rect.size.height = newSize.height;
            rect.origin.x = 0;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = newSize.width;
            rect.size.height = oldsize.height*(newSize.width/oldsize.width);
            rect.origin.x = 0;
            rect.origin.y = 0;
        }
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (void)dealloc
{
    NSLog(@"PhotoTool被释放掉了");
}

@end
