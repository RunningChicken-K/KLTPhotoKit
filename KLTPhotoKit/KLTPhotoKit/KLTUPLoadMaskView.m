//
//  UPLoadMaskView.m
//  PhotoUploader
//
//  Created by 孔令涛 on 2017/4/18.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "KLTUPLoadMaskView.h"


@interface KLTUPLoadMaskView()

@property(nonatomic,strong)UILabel * progressLabel;

@end

@implementation KLTUPLoadMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        [self addSubview:self.progressLabel];
        self.progress = @"0.00%";

    }
    return self;
}

- (void)setProgress:(NSString *)progress
{
    _progress = progress;
    self.progressLabel.text = progress;
}

- (UILabel *)progressLabel
{
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        _progressLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _progressLabel.font = [UIFont systemFontOfSize:15 weight:-1.0f];
        _progressLabel.backgroundColor = [UIColor clearColor];
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _progressLabel;
}




@end
