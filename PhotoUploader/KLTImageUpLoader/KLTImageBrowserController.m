//
//  ImageBrowserController.m
//  ChongZu
//
//  Created by 孔令涛 on 2017/1/4.
//  Copyright © 2017年 cz10000. All rights reserved.
//

#import "KLTImageBrowserController.h"
#import "KLTImageUploaderDefine.h"
#import "KLTAsset.h"


#define ContentViewHeight kScreenHeight

@interface KLTImageBrowserController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * baseScrollView;


@property(nonatomic,strong)UILabel * pageCountLabel;
 
@property(nonatomic,assign)NSInteger numberOfPage;

@end

@implementation KLTImageBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"预览";
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25,25);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"klt_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];;

    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarBtn];


    
    self.currentPage = self.currentPage +1;
    
    [self.view addSubview:self.baseScrollView];
    [self.view addSubview:self.pageCountLabel];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.hidesBarsOnTap = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnTap = YES;
}
- (void)leftBarBtnClicked:(UIBarButtonItem *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setAssetsArray:(NSArray *)assetsArray
{
    _assetsArray = assetsArray;
    NSInteger i = 0;
    self.numberOfPage = assetsArray.count;
    for ( KLTAsset * asset in assetsArray) {
        
        UIScrollView * contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, ContentViewHeight)];
        [self.baseScrollView addSubview:contentScrollView];
        contentScrollView.maximumZoomScale = 2;
        contentScrollView.minimumZoomScale = 1;
        contentScrollView.delegate = self;
        contentScrollView.showsVerticalScrollIndicator = NO;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        [contentScrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        
        
        PHImageManager * manager  = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset.asset targetSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"img.size is %@",NSStringFromCGSize(result.size));
            imageView.image = result;
            
            CGFloat width = kScreenWidth;
            CGFloat height = kScreenWidth / result.size.width * result.size.height;
            
            imageView.bounds = CGRectMake(0, 0, width, height);
            contentScrollView.contentSize = CGSizeMake(width, height);
            if (height > ContentViewHeight) {
                imageView.center = CGPointMake(width/2, height/2);
            }
            else
            {
                imageView.center = CGPointMake(kScreenWidth/2, (ContentViewHeight)/2);
            }
        }];
        
        i++;
        
    }
    
    self.baseScrollView.contentSize = CGSizeMake(i * kScreenWidth, 0);
    [self.baseScrollView setContentOffset:CGPointMake(kScreenWidth * _currentPage, 0)];
    
}
- (UIScrollView *)baseScrollView
{
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth, kScreenHeight)];
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.pagingEnabled = YES;
        
        _baseScrollView.delegate = self;
        
    }
    return _baseScrollView;
}


- (UILabel *)pageCountLabel
{
    if (_pageCountLabel == nil) {
        _pageCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        _pageCountLabel.text = [NSString stringWithFormat:@"%ld / %ld",(long)_currentPage,(long)_numberOfPage];
        _pageCountLabel.textColor = [UIColor whiteColor];
        _pageCountLabel.textAlignment = NSTextAlignmentCenter;
        _pageCountLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _pageCountLabel.center = CGPointMake(kScreenWidth/2, kScreenHeight - 50);
        _pageCountLabel.layer.cornerRadius = 10;
        _pageCountLabel.clipsToBounds = YES;
    }
    return _pageCountLabel;
}
- (void)setNumberOfPage:(NSInteger)numberOfPage
{
    _numberOfPage = numberOfPage;
    self.pageCountLabel.text = [NSString stringWithFormat:@"%ld / %ld",(long)_currentPage,(long)_numberOfPage];
}
- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    self.pageCountLabel.text = [NSString stringWithFormat:@"%ld / %ld",(long)_currentPage,(long)_numberOfPage];
}
#pragma mark- ScrollView代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews.firstObject;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView * imgView = scrollView.subviews.firstObject;
    if (scrollView.zoomScale <= 1.0) {
        imgView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    }
    else
    {
        imgView.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height < kScreenHeight ? kScreenHeight/2 : scrollView.contentSize.height/2);
    }

    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scale <= 1) {
        view.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    }
    else
    {
        view.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height < kScreenHeight?kScreenHeight/2:scrollView.contentSize.height/2);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.baseScrollView) {
        self.currentPage = scrollView.contentOffset.x / kScreenWidth + 1;
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
