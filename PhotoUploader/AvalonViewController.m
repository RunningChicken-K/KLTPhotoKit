//
//  AvalonViewController.m
//  PhotoUploader
//
//  Created by CZ10000 on 2017/7/27.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "AvalonViewController.h"
#import "KLTPhotoKit.h"

/**
 使用字典或数组生成Json字符串
 */
#define JsonWtihObject(obj) [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]

@interface AvalonViewController ()
@property(nonatomic,strong)UIScrollView * baseScrollView;

@end

@implementation AvalonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.baseScrollView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"选择图片" style:UIBarButtonItemStyleDone target:self action:@selector(choose:)];
    
}
- (UIScrollView *)baseScrollView
{
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _baseScrollView;
}
- (void)choose:(UIBarButtonItem *)barBtn
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"单张图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [KLTPhotoKit singlePhotoWithSource:PhotoSourceFromCameraAndAlbum alertTitle:@"选择图片" alertMessage:@"选择一张图片 Choose a Photo" AllEdit:YES ScaleSize:CGSizeZero CompressRate:1 Completion:^(UIImage *image) {
            
            [self RefreshUI:@[image]];
            
            
            
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"多图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [KLTPhotoKit multiPhotosWithTargetSize:CGSizeMake(400, 400) LimitCount:3  Completion:^(NSArray *imagesArray) {
            
            //NSLog(@"imageArray is %@",imagesArray);
            
//            NSMutableDictionary * imgDict = [[NSMutableDictionary alloc]init];
//            
//            NSInteger i = 1;
//            for (UIImage * image in imagesArray) {
//                [imgDict setValue:image forKey:[NSString stringWithFormat:@"pic%ld",(long)i]];
//                i ++;
//            }
//            //NSLog(@"%@",imgDict);
//            [KLTPhotoKit uploadImages:imgDict Url:@"http://192.168.199.112/index.php?m=Coshow&a=addInfo" Parameters:@{@"userid":@"101",@"content":@"aaa",@"pics":JsonWtihObject(imgDict.allKeys),@"array":@[@1,@2,@3,@4]} Progress:^(CGFloat progress) {
//                NSLog(@"进度 %f",progress);
//            } Completion:^(NSData *data, NSError *error) {
//                NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
//            }];
//            
//            for (UIView * view in self.baseScrollView.subviews) {
//                [view removeFromSuperview];
//            }
            
            
            [self RefreshUI:imagesArray];
            

        }];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
- (void)RefreshUI:(NSArray *)images
{
    
    

    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat height = [UIScreen mainScreen].bounds.size.width/3;
    
    for (UIImage * image in images) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imageView.image = image;
        [self.baseScrollView addSubview:imageView];
        x += width;
        if (x >= [UIScreen mainScreen].bounds.size.width) {
            x = 0;
            y += width;
        }
        [self.baseScrollView addSubview:imageView];
    }
    
    self.baseScrollView.contentSize = CGSizeMake(0, y + width);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
