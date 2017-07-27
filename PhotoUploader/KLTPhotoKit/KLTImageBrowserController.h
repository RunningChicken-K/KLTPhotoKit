//
//  ImageBrowserController.h
//  ChongZu
//
//  Created by 孔令涛 on 2017/1/4.
//  Copyright © 2017年 cz10000. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTImageBrowserController : UIViewController


@property(nonatomic,copy)NSMutableArray * assetsArray;


@property(nonatomic,assign)NSInteger  currentPage;

@property(nonatomic,strong) void (^willPop)(NSMutableArray * increaseAssets);
- (void)setWillPop:(void (^)(NSMutableArray * increaseAssets))willPop;

@end
