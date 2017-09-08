//
//  KLTEditImageViewController.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/22.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTEditImageViewController.h"
#import "KLTImageUploaderDefine.h"
#import "KLTFilter.h"
@import Photos;

#define BottomMenuWidth (kScreenWidth/4)
#define BottomIconWidth 25
#define OperationViewHeight 120

@interface KLTEditImageViewController ()

@property(nonatomic,strong)UIScrollView * baseScrollView;

@property(nonatomic,strong)UIImageView * imageView;

@property(nonatomic,strong)UIImage * image;
//渲染后的图片
@property(nonatomic,strong)UIImage * renderImage;

@property(nonatomic,strong)UIView * navView;

@property(nonatomic,strong)UIView * editToolView;

@property(nonatomic,strong)UIView * effectView;
@property(nonatomic,strong)UIImageView * effectImageView;
@property(nonatomic,strong)UIView * colorAdjustView;
@property(nonatomic,strong)UIImageView * colorAdjustImageView;
@property(nonatomic,strong)UIView * contrastView;
@property(nonatomic,strong)UIImageView * contrastImageView;
@property(nonatomic,strong)UIView * groupView;
@property(nonatomic,strong)UIImageView * groupImageView;

@property(nonatomic,strong)UIView * currentOperationView;



@property(nonatomic,strong)UIScrollView * operationView;


@property(nonatomic,copy)NSArray * effectTitleArray;
@property(nonatomic,copy)NSArray * effectFilterArray;
@property(nonatomic,copy)NSArray * effectIconArray;

@property(nonatomic,strong)UIView * currentSelectEffectView;


@property(nonatomic,strong)UISlider * redSlider;
@property(nonatomic,strong)UISlider * greenSlider;
@property(nonatomic,strong)UISlider * blueSlider;

@property(nonatomic,strong)UISlider * brightnessSlider;
@property(nonatomic,strong)UISlider * contrastSlider;
@property(nonatomic,strong)UISlider * saturationSlider;




@property(nonatomic,strong)KLTFilter * filter;



@end

@implementation KLTEditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.baseScrollView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.editToolView];
    [self.view addSubview:self.operationView];
    
}

- (void)cancel:(UIButton *)btn
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
- (void)complete:(UIButton *)btn
{
    
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:self.renderImage];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        if (success)
        {
            //成功后取相册中的图片对象
            __block PHAsset *imageAsset = nil;
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                imageAsset = obj;
                *stop = YES;
                
            }];
            
            if (imageAsset)
            {
                self.sourceAsset.selected = NO;
                KLTAsset * asset = [[KLTAsset alloc]init];
                asset.asset = imageAsset;
                asset.selected = YES;
                
                if (self.editSuccess) {
                    self.editSuccess(self.replaceIndex, asset);
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        
    }];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (UIScrollView *)baseScrollView
{
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight)];
        _baseScrollView.zoomScale = YES;
        _baseScrollView.minimumZoomScale = 0.5f;
        _baseScrollView.maximumZoomScale = 2.0f;
        //_baseScrollView.delegate = self;
        
        [_baseScrollView addSubview:self.imageView];
        
        
        PHImageManager * manager  = [PHImageManager defaultManager];
        [manager requestImageForAsset:self.sourceAsset.asset targetSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            self.image = result;
            
        }];
        
    }
    return _baseScrollView;
}
- (UIScrollView *)operationView
{
    if (_operationView == nil) {
        _operationView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44 -  OperationViewHeight, kScreenWidth, OperationViewHeight)];
        _operationView.contentSize = CGSizeMake(0, kScreenWidth * 4);
        _operationView.scrollEnabled = NO;
        _operationView.hidden = YES;
        _operationView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        
        [_operationView addSubview:self.effectView];
        [_operationView addSubview:self.colorAdjustView];
        [_operationView addSubview:self.contrastView];
        [_operationView addSubview:self.groupView];
        self.effectView.frame = CGRectMake(0, 0, kScreenWidth, OperationViewHeight);
        self.colorAdjustView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, OperationViewHeight);
        self.contrastView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, OperationViewHeight);
        self.groupView.frame = CGRectMake(kScreenWidth * 3, 0, kScreenWidth, OperationViewHeight);
        
        
        
    }
    return _operationView;
}

- (NSArray *)effectTitleArray
{
    if (_effectTitleArray == nil) {
        _effectTitleArray = @[@"默认",@"黑白",@"古典",@"老照片",@"冷色",@"暖色",@"棕色",@"素描"];
    }
    return _effectTitleArray;
}
- (NSArray *)effectFilterArray
{
    if (_effectFilterArray == nil) {
        _effectFilterArray = @[kNoneEffect,kCIPhotoEffectTonal,kCIPhotoEffectChrome,kCIPhotoEffectInstant,kCIPhotoEffectProcess,kCIPhotoEffectTransfer,kCISepiaTone,kCILineOverlay];
    }
    return _effectFilterArray;
}
- (NSArray *)effectIconArray
{
    if (_effectIconArray == nil) {
        _effectIconArray = @[];
    }
    return _effectIconArray;
}
- (UIView *)effectView
{
    if (_effectView == nil) {
        _effectView = [[UIView alloc]initWithFrame:CGRectZero];
        //_effectView.backgroundColor = [UIColor orangeColor];
        
        UIScrollView * contentScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, OperationViewHeight)];
        contentScro.showsHorizontalScrollIndicator = NO;
        [_effectView addSubview:contentScro];
        
        CGFloat x = 0;
        CGFloat y = 5;
        CGFloat titleY = OperationViewHeight - 25;
        CGFloat WH = 80;
        
        for (NSInteger i = 0; i < self.effectTitleArray.count; i ++) {
            
            UIView * efView = [[UIView alloc]initWithFrame:CGRectMake(x, y, 90, OperationViewHeight)];
            [efView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectEffect:)]];
            efView.tag = i;
            [contentScro addSubview:efView];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, WH, WH)];
            imageView.backgroundColor = [UIColor orangeColor];
            [efView addSubview:imageView];
            
            UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,titleY, WH, 15)];
            titleLabel.text = self.effectTitleArray[i];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:12 weight:-0.5];
            titleLabel.textColor = [UIColor whiteColor];
            [efView addSubview:titleLabel];
            
            x += 90;
        }
        
        contentScro.contentSize = CGSizeMake(x, 0);
        

    }
    return _effectView;
}
- (UIView *)colorAdjustView
{
    if (_colorAdjustView == nil) {
        _colorAdjustView = [[UIView alloc]initWithFrame:CGRectZero];
        //_colorAdjustView.backgroundColor = [UIColor blueColor];
        
        for (NSInteger i = 0; i < 3; i++) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, OperationViewHeight/3 * i, kScreenWidth, OperationViewHeight/3)];
            [_colorAdjustView addSubview:view];
            
            UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 10)];
            slider.value = 1.0f;
            
            
            [slider setThumbImage:[UIImage imageNamed:@"klt_slider"] forState:UIControlStateNormal];
            slider.center = CGPointMake(kScreenWidth/2 + 20, OperationViewHeight/3/2);
            [view addSubview:slider];
            
            UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 30, 20)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.center = CGPointMake(titleLabel.center.x, OperationViewHeight/3/2);
            
            switch (i) {
                case 0:
                    _redSlider = slider;
                    titleLabel.text = @"R";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                case 1:
                    _greenSlider = slider;
                    titleLabel.text = @"G";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                case 2:
                    _blueSlider = slider;
                    titleLabel.text = @"B";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                    
                default:
                    break;
            }
            
            [view addSubview:titleLabel];
            
            [slider addTarget:self action:@selector(colorChanged:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return _colorAdjustView;
}
- (UIView *)contrastView
{
    if (_contrastView == nil) {
        _contrastView = [[UIView alloc]initWithFrame:CGRectZero];
        //_contrastView.backgroundColor = [UIColor redColor];
        
        for (NSInteger i = 0; i < 3; i++) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, OperationViewHeight/3 * i, kScreenWidth, OperationViewHeight/3)];
            [_contrastView addSubview:view];
            
            UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 20)];
            slider.center = CGPointMake(kScreenWidth/2 + 20, OperationViewHeight/3/2);
            [slider setThumbImage:[UIImage imageNamed:@"klt_slider"] forState:UIControlStateNormal];
            [slider addTarget:self action:@selector(colorControl:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:slider];
            
            UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 20)];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.center = CGPointMake(titleLabel.center.x, OperationViewHeight/3/2);
            
            switch (i) {
                case 0:
                    _brightnessSlider = slider;
                    _brightnessSlider.value = 0.0f;
                    titleLabel.text = @"亮度";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                case 1:
                    _contrastSlider = slider;
                    _contrastSlider.value = 0.2f;
                    titleLabel.text = @"对比度";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                case 2:
                    _saturationSlider = slider;
                    _saturationSlider.value = 0.5f;
                    titleLabel.text = @"饱和度";
                    slider.minimumTrackTintColor = ColorFromRGBA(0x1296db, 1);
                    break;
                    
                default:
                    break;
            }
            
            [view addSubview:titleLabel];
        }
        
    }
    return _contrastView;
}
- (UIView *)groupView
{
    if (_groupView == nil) {
        _groupView = [[UIView alloc]initWithFrame:CGRectZero];
        //_groupView.backgroundColor = [UIColor greenColor];
    }
    return _groupView;
}
- (UIView *)navView
{
    if (_navView == nil) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        
        _navView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(15, 27, 60, 20);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:cancelBtn];
        
        UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(kScreenWidth - 75, 27, 60, 20);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn setTitleColor:ColorFromRGBA(0x00B642, 1) forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:completeBtn];
    }
    return _navView;
}
- (UIView *)editToolView
{
    if (_editToolView == nil) {
        _editToolView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
        _editToolView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        UIView * effectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BottomMenuWidth, 44)];
        effectView.tag = 0;
        [effectView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTaped:)]];
        [_editToolView addSubview:effectView];
        _effectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BottomIconWidth, BottomIconWidth)];
        _effectImageView.image = [UIImage imageNamed:@"effect_unselected"];
        _effectImageView.center = CGPointMake(BottomMenuWidth/2, 22);
        [effectView addSubview:_effectImageView];
        
        UIView * colorAdjustView = [[UIView alloc]initWithFrame:CGRectMake(BottomMenuWidth, 0, BottomMenuWidth, 44)];
        colorAdjustView.tag = 1;
        [_editToolView addSubview:colorAdjustView];
        [colorAdjustView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTaped:)]];
        _colorAdjustImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BottomIconWidth, BottomIconWidth)];
        _colorAdjustImageView.center = CGPointMake(BottomMenuWidth/2, 22);
        _colorAdjustImageView.image = [UIImage imageNamed:@"coloradjust_unselected"];
        [colorAdjustView addSubview:_colorAdjustImageView];
        
        
        UIView * contrastView = [[UIView alloc]initWithFrame:CGRectMake(BottomMenuWidth * 2, 0, BottomMenuWidth, 44)];
        contrastView.tag = 2;
        [_editToolView addSubview:contrastView];
        [contrastView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTaped:)]];
        _contrastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BottomIconWidth, BottomIconWidth)];
        _contrastImageView.center = CGPointMake(BottomMenuWidth/2, 22);
        _contrastImageView.image = [UIImage imageNamed:@"contrast_unselected"];
        [contrastView addSubview:_contrastImageView];
        
        UIView * groupView = [[UIView alloc]initWithFrame:CGRectMake(BottomMenuWidth * 3, 0, BottomMenuWidth, 44)];
        groupView.tag = 3;
        [_editToolView addSubview:groupView];
        [groupView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTaped:)]];
        _groupImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BottomIconWidth, BottomIconWidth)];
        _groupImageView.center = CGPointMake(BottomMenuWidth/2, 22);
        _groupImageView.image = [UIImage imageNamed:@"group_unselected"];
        [groupView addSubview:_groupImageView];
    }
    
    return _editToolView;
}

- (void)bottomViewTaped:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    
    if (_currentOperationView && _currentOperationView == tap.view) {
        self.operationView.hidden = YES;
        _currentOperationView = nil;
        return;
    }
    _currentOperationView = tap.view;
    
    _effectImageView.image = [UIImage imageNamed:@"effect_unselected"];
    _colorAdjustImageView.image = [UIImage imageNamed:@"coloradjust_unselected"];
    _contrastImageView.image = [UIImage imageNamed:@"contrast_unselected"];
    _groupImageView.image = [UIImage imageNamed:@"group_unselected"];
    
    switch (tag) {
        case 0:
            _effectImageView.image = [UIImage imageNamed:@"effect_selected"];
            break;
        case 1:
            _colorAdjustImageView.image = [UIImage imageNamed:@"coloradjust_selected"];
            break;
        case 2:
            _contrastImageView.image = [UIImage imageNamed:@"contrast_selected"];
            break;
        case 3:
            _groupImageView.image = [UIImage imageNamed:@"group_selected"];
            break;
            
        default:
            break;
    }
    
    
    [self showMenu:tag];
    
}
- (void)showMenu:(NSInteger)tag
{
    [self.operationView setContentOffset:CGPointMake(kScreenWidth * tag, 0) animated:YES];
    self.operationView.hidden = NO;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenWidth / image.size.width * image.size.height;
    
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    
    self.imageView.image = image;
    
}

- (void)selectEffect:(UITapGestureRecognizer *)tap
{
    if (_currentSelectEffectView) {
        _currentSelectEffectView.backgroundColor = [UIColor clearColor];
    }
    _currentSelectEffectView = tap.view;
    _currentSelectEffectView.backgroundColor = ColorFromRGBA(0x00B642, 1);
    
    NSDictionary * parameters = nil;
    if (tap.view.tag == 7) {
    parameters = @{@"inputNRNoiseLevel":@0.07,@"inputThreshold":@0.1,@"inputNRSharpness":@0.71,@"inputEdgeIntensity":@1.0,@"inputContrast":@50.00};
    }
    
    [self.filter setEffectFilter:self.effectFilterArray[tap.view.tag] Parameters:parameters];
    
    [self render];
    

}
- (void)colorChanged:(UISlider *)slider
{
    [self.filter setColorCubeWithRed:_redSlider.value Green:_greenSlider.value Blue:_blueSlider.value];
    [self render];
}
- (void)colorControl:(UISlider *)slider
{
    CGFloat bri = self.brightnessSlider.value * 2 - 1;
    CGFloat con = self.contrastSlider.value * 3.75 + 0.25;
    CGFloat sat = self.saturationSlider.value * 2;
    
    [self.filter setColorControlWithBrightness:bri Contrast:con Saturation:sat];
    [self render];
}
- (void)render
{
    __weak __typeof(self) weakself = self;
    [self.filter render:^(UIImage *resultImage) {
        weakself.imageView.image = resultImage;
        weakself.renderImage = resultImage;
    }];
}

- (KLTFilter *)filter
{
    if (_filter == nil) {
        _filter = [KLTFilter filterWithSourceImage:self.image];
    }
    return _filter;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
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
