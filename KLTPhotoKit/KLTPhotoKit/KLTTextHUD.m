//
//  KLTTextHUD.m
//  PhotoUploader
//
//  Created by CZ10000 on 2017/8/2.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTTextHUD.h"

@interface KLTTextHUD()

@property(nonatomic,copy)NSString * text;

@end

@implementation KLTTextHUD

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showWithText:(NSString *)text InView:(UIView *)view
{
    KLTTextHUD * hud = [[KLTTextHUD alloc]initWithFrame:view.bounds Text:text];
    
    [view addSubview:hud];
}

- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text
{
    if (self = [super initWithFrame:frame]) {
        
        self.text = text;
        [self setUpText];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hudHidden:) userInfo:nil repeats:NO];
        
    }
    return self;
}

- (void)setUpText
{
    
    CGRect rect =  [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width - 150,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 100,rect.size.height + 30)];
    backView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    backView.layer.cornerRadius = 10.0f;
    backView.clipsToBounds = YES;
    [self addSubview:backView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.center = CGPointMake(backView.bounds.size.width/2, backView.bounds.size.height/2);
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = self.text;
    [backView addSubview:label];
}

- (void)hudHidden:(NSTimer *)timer
{
    self.hidden = YES;
    [self removeFromSuperview];
    
    [timer invalidate];
}

@end

















