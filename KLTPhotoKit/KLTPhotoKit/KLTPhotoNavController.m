//
//  KLTPhotoNavController.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/5.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTPhotoNavController.h"

@interface KLTPhotoNavController ()

@end

@implementation KLTPhotoNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
