//
//  KLTAlbumPhotoList.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/26.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTAlbumPhotoList.h"
#import "KLTImageUploaderDefine.h"
#import "KLTAssetCell.h"
#import "KLTAsset.h"
#import "KLTImageBrowserController.h"

static CGFloat BottomViewHieght = 40;

@import Photos;

@interface KLTAlbumPhotoList ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,strong)UICollectionView * collectionView;


@property(nonatomic,strong)PHFetchResult * fetchResult;

@property(nonatomic,strong)NSMutableArray * collectionAssetResults;

/**
 被选择的资源
 */
@property(nonatomic,strong)NSMutableArray * resultArray;

/**
 被选中的图片资源个数
 */
@property(nonatomic,assign)NSInteger  numberOfSelectAssets;

/**
 相册中所有的资源
 */
@property(nonatomic,strong)NSMutableArray * assetsArray;

@property(nonatomic,strong)NSDateFormatter * dateFormatter;

@property(nonatomic,strong)UIView * bottomView;

@property(nonatomic,strong)UIButton * completeBtn;

@property(nonatomic,strong)UIButton * previewBtn;

@end

@implementation KLTAlbumPhotoList


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.targetSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    

    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    //请求相册访问权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
       
        if (status == PHAuthorizationStatusAuthorized) {
            [self loadAssetCollectionForDisplay];
        }
        else
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"你已经关闭了本应用对相册的访问权限，请前往 设置->隐私->照片 更改设置" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    }];
    
 
    
}

- (void)cancel:(UIBarButtonItem *)barBtn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadAssetCollectionForDisplay
{
    PHFetchOptions  * options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]];
    self.fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment subtype:PHAssetCollectionSubtypeAny options:options];
    
    
    for (PHAssetCollection * collection in self.fetchResult) {
        PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        
        for (PHAsset * asset in result) {
            
            KLTAsset * model = [[KLTAsset alloc]init];
            model.asset = asset;
            
            [self.assetsArray addObject:model];
        }
        
    }
    //NSLog(@"%@",[NSThread currentThread]);
    
    dispatch_main_sync_safe(^{
        [self.collectionView reloadData];
    });
    
    
}
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0 ;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - BottomViewHieght) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"KLTAssetCell" bundle:nil] forCellWithReuseIdentifier:@"KLTAssetCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - BottomViewHieght, kScreenWidth, BottomViewHieght)];
        _bottomView.backgroundColor = ColorFromRGBA(0xFEFEFE, 1);
        
        [_bottomView addSubview:self.previewBtn];
        [_bottomView addSubview:self.completeBtn];
        
        
        CALayer * topLine = [CALayer layer];
        topLine.backgroundColor = ColorFromRGBA(0xAAAAAA, 1).CGColor;
        topLine.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
        [_bottomView.layer addSublayer:topLine];
    }
    return _bottomView;
}
- (UIButton *)previewBtn
{
    if (_previewBtn == nil) {
        _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewBtn.enabled = NO;
        _previewBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _previewBtn.frame = CGRectMake(15, 0, 60, BottomViewHieght);
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_previewBtn addTarget:self action:@selector(preview:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewBtn;
}
- (void)preview:(UIButton *)btn
{
    NSMutableArray * previewArray = [NSMutableArray array];
    
    for (KLTAsset * asset in self.assetsArray) {
        if (asset.selected) {
            [previewArray addObject:asset];
        }
    }
    
    KLTImageBrowserController * kvc = [[KLTImageBrowserController alloc]init];
    kvc.assetsArray = previewArray;
    __weak typeof(self) weakself = self;
    [kvc setWillPop:^(NSMutableArray * increAssets){
        [weakself.assetsArray addObjectsFromArray:increAssets];
        [weakself.collectionView reloadData];
        
    }];
    [self.navigationController pushViewController:kvc animated:YES];
    
}
- (UIButton *)completeBtn
{
    if (_completeBtn == nil) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.enabled = NO;
        _completeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _completeBtn.frame = CGRectMake(kScreenWidth - 100, 0 , 85, BottomViewHieght);
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:ColorFromRGBA(0xd1f1c0, 1)forState:UIControlStateNormal];
        
        [_completeBtn  addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
- (void)complete:(UIButton *)btn
{
    
    PHImageManager * manager = [PHImageManager defaultManager];
    NSMutableArray * imageArray = [[NSMutableArray alloc]initWithCapacity:self.resultArray.count];
    for (NSInteger i = 0; i < self.resultArray.count ; i ++) {
        [imageArray addObject:@""];
    }
    
    for (NSInteger i = 0; i < self.resultArray.count ; i ++) {
        KLTAsset * asset = self.resultArray[i];
            [manager requestImageForAsset:asset.asset targetSize:self.targetSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                CGFloat resultWidth = result.size.width;
                CGFloat resultHeight = result.size.height;
                
                CGFloat bigger = resultHeight > resultWidth ?resultHeight:resultWidth;
                //PHImageManager返回的缩略图跟根据图片实际尺寸进行缩放  但是经测试宽高均不会超过40（待验证）
                if (bigger > 40) {
                    //如果返回的不是缩略图  则添加到结果数组
                    [imageArray replaceObjectAtIndex:i withObject:result];
                    
                    //验证是否数组中所有结果都已经填充
                    //如果已全部填充  则调用回调Block
                    BOOL complete = YES;
                    for (id obj in imageArray) {
                        if ([obj isEqual:@""]) {
                            complete = NO;
                            break;
                        }
                    }
                    if (complete) {
 
                        [self.navigationController dismissViewControllerAnimated:YES completion:^{
                            if (self.didSelectImages) {
                                self.didSelectImages(imageArray);
                            }
                        }];

                    }
                }
                
            }];
        }
    
    
}
- (void)setNumberOfSelectAssets:(NSInteger)numberOfSelectAssets
{
    _numberOfSelectAssets = numberOfSelectAssets;
    if (numberOfSelectAssets < 0 ) {
        _numberOfSelectAssets = 0;
    }
    
    if (numberOfSelectAssets) {
        self.completeBtn.enabled = YES;
        [self.completeBtn setTitleColor:ColorFromRGBA(0x00B642, 1) forState:UIControlStateNormal];
        [self.completeBtn setTitle:[NSString stringWithFormat:@"完成(%ld)",(long)_numberOfSelectAssets] forState:UIControlStateNormal];
        
        [self.previewBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        self.previewBtn.enabled = YES;
    }
    else
    {
        self.completeBtn.enabled = NO;
        [self.completeBtn setTitleColor:ColorFromRGBA(0xd1f1c0, 1) forState:UIControlStateNormal];
        [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.previewBtn.enabled = NO;
    }
    
}

- (NSMutableArray *)resultArray
{
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (NSMutableArray *)assetsArray
{
    if (_assetsArray == nil) {
        _assetsArray = [[NSMutableArray alloc]init];
    }
    return _assetsArray;
}
- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    return _dateFormatter;
}


#pragma mark- CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLTAssetCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLTAssetCell" forIndexPath:indexPath];
    KLTAsset * asset = self.assetsArray[indexPath.row];
    
    cell.asset = asset;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLTAsset * asset = self.assetsArray[indexPath.row];
    asset.selected  = !asset.selected;
    if (!asset.selected) {
        @synchronized (self) {
            self.numberOfSelectAssets = self.numberOfSelectAssets -1;
        }
        
        [self.resultArray removeObject:asset];
        
    }
    else
    {
        @synchronized (self) {
            self.numberOfSelectAssets = self.numberOfSelectAssets + 1;
        }
        
        [self.resultArray addObject:asset];
    }
  
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
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
