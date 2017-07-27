//
//  FPSLabel.m
//  CollectionViewDemo
//
//  Created by 孔令涛 on 2017/2/22.
//  Copyright © 2017年 KongLT. All rights reserved.
//

#import "FPSLabel.h"

@interface FPSLabel ()
@property(nonatomic,assign) NSUInteger count;
@property(nonatomic,assign) NSTimeInterval lastTime;


@end

@implementation FPSLabel

- (instancetype)initWithPosition:(CGPoint)position
{
    if (self = [super init]) {
        CGFloat x = position.x;
        CGFloat y = position.y;
        
        self.frame = CGRectMake(x, y, 80, 30);
        
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(dealDisplayLink:)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}
+ (instancetype)FPSLabelWithPosition:(CGPoint)position
{
    return [[self alloc]initWithPosition:position];
}
- (void)dealDisplayLink:(CADisplayLink *)link
{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    self.attributedText = text;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
