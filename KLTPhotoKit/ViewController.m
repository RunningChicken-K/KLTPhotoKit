//
//  ViewController.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/3/31.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "ViewController.h"
#import "KLTSinglePhotoPicker.h"
#import "UIImageView+KLTUPLoad.h"
#import "KLTImageUPLoader.h"


#define DictWithJsonData(data) [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]

#define JsonWtihObject(obj) [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (IBAction)selectImage:(id)sender {
    
    NSString * url = @"http://kfpet.cz10000.com/index.php?m=Czculture&a=addimg";
    NSDictionary * parameters = @{@"appid":@"2016",@"appselect":@"cz2016",@"userid":@"336",@"action":@"add"};
    
    KLTImageUPLoader * uploader =  [_imagView uploadSingleImageWithUrl:url FileName:@"pic" Prarmeters:parameters Completion:^(NSData *data,UIImageView * imageView) {
        NSLog(@"上传成功");
        NSLog(@"%@",DictWithJsonData(data));
    }];
    uploader.photoTool.photoSource = PhotoSourceFromCameraAndAlbum;
    uploader.photoTool.CompressRate = 0.1;
    uploader.photoTool.scaleSize = CGSizeMake(800, 800);
    [uploader uploadImage];



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
