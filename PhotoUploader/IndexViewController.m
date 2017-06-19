//
//  IndexViewController.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/24.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "IndexViewController.h"
#import "KLTAlbumPhotoList.h"


@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"PhotoKit";
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        KLTAlbumPhotoList * kap = [[KLTAlbumPhotoList alloc]init];
        
        [self.navigationController pushViewController:kap animated:YES];
    }
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
