//
//  FilterViewController.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/5/8.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "FilterViewController.h"
#import "KLTImageUploaderDefine.h"
#import "KLTFilter.h"
#import "KLTSinglePhotoPicker.h"
@import CoreImage;

@interface FilterViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,KLTSinglePhotoPickerDelegate>

@property(nonatomic,weak)IBOutlet UIImageView * originalImageView;

@property(nonatomic,weak)IBOutlet UIImageView * transitionImageView;

@property(nonatomic,strong)UIImage * originalImage;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property(nonatomic,copy)NSArray * categoryArray;
@property(nonatomic,copy)NSArray * filtersArray;

@property(nonatomic,copy)NSArray * currentFiltersArray;

@property(nonatomic,copy)NSString * currentFilterName;


@property(nonatomic,strong)CIContext * context;


@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dealData];
    
    
}
- (void)dealData
{
    NSDictionary * filters = [KLTFilter allFilter];
    
    _categoryArray = [filters allKeys];
    _filtersArray = [filters allValues];
    _currentFiltersArray = [_filtersArray firstObject];
    [self.pickerView reloadAllComponents];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.categoryArray.count;
    }
    else
    {
        return self.currentFiltersArray.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.currentFiltersArray = self.filtersArray[row];
        self.currentFilterName = [self.currentFiltersArray firstObject];
        [pickerView reloadComponent:1];
    }
    else
    {
        self.currentFilterName = self.currentFiltersArray[row];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.categoryArray[row];
    }
    else
    {
        return self.currentFiltersArray[row];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:11]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth/2;
}


- (CIContext *)context
{
    if (_context == nil) {
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
}


- (IBAction)selectImage:(id)sender {
    
    __weak __typeof(self) weakself = self;
    
    KLTSinglePhotoPicker * phototool = [KLTSinglePhotoPicker photoTool];
    [phototool obtainSinglePhotoWithCompletion:^(UIImage *image) {
        weakself.originalImageView.image = image;
        weakself.originalImage = image;
    }];
    
}
- (void)didCancelPickImage
{

}

- (IBAction)render:(id)sender {
    
    
    dispatch_async(dispatch_queue_create("queue", NULL), ^{
        CIFilter * filter = [CIFilter filterWithName:_currentFilterName];
        CGImageRef  cgimage = [_originalImage CGImage];
        CIImage * ciimage = [CIImage imageWithCGImage:cgimage];
        
        [filter setValue:ciimage forKey:kCIInputImageKey];
        //[filter setValue:@0.8f forKey:kCIInputIntensityKey];
        NSLog(@"%@",[filter attributes]);
        
        CIImage * result = [filter valueForKey:kCIOutputImageKey];
    
        
        //CIContext * context = [CIContext contextWithOptions:nil];
        //NSLog(@"%@",NSStringFromCGRect([result extent]));
        //NSLog(@"%@",NSStringFromCGSize(originalImage.size));
        CGRect extent = CGRectMake(0, 0, _originalImage.size.width, _originalImage.size.height); //[result extent];
        CGImageRef cgres = [self.context createCGImage:result fromRect:extent];
        //NSLog(@"%@",[NSThread currentThread]);
        dispatch_main_sync_safe(^{
            NSLog(@"%@",[NSThread currentThread]);
            self.transitionImageView.image = [UIImage imageWithCGImage:cgres];
        });
    });
    
    kCIAttributeTypeScalar
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
