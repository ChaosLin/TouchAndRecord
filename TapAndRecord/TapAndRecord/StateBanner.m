//
//  StateShowView.m
//  test_record
//
//  Created by Renton Lin on 13-11-29.
//  Copyright (c) 2013年 Renton Lin. All rights reserved.
//

#import "StateBanner.h"
//#import "CommonMacro.h"

static StateBanner* banner = nil;

@interface StateBanner()
@property (nonatomic, strong) UIView* view_toast;
@property (nonatomic, strong) UIImageView* imageView_state;
@property (nonatomic, strong) UIImageView* imageView_labelBack;
@property (nonatomic, strong) UILabel* label_description;
@property (nonatomic, strong) UIImageView* prgressView;
- (void)display;
@end

@implementation StateBanner
#define MINVOLUMN   0
#define MAXVOLUMN   6

#pragma mark - Singleton
+ (StateBanner*)sharedInstance
{
    if (!banner)
    {
        banner = [[StateBanner alloc]init];
    }
    return banner;
}

+ (void)destroy
{
    banner.view_toast.hidden = YES;
    [banner.view_toast removeFromSuperview];
    banner = nil;
}

- (id)init
{
    if (self = [super init])
    {
        _maxProcessValue = 3 * 60;
    }
    return self;
}

- (UIImage*)resizeImage:(UIImage*)image_origin
{
    CGFloat hInset = floorf(image_origin.size.width / 2);
    CGFloat vInset = floorf(image_origin.size.height / 2);
    UIEdgeInsets insets = UIEdgeInsetsMake(vInset, hInset, vInset, hInset);
    UIImage* image_new = [image_origin resizableImageWithCapInsets:insets];
    return image_new;
}

- (void)show
{
    if (!self.view_toast)
    {
        self.view_toast = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
//        self.view_toast.windowLevel = UIWindowLevelStatusBar;
        self.view_toast.layer.zPosition = 0.7;
        self.view_toast.backgroundColor = [UIColor clearColor];
        UIView* view_back = [[UIView alloc]initWithFrame:CGRectMake(88, 194, 151, 156)];
        view_back.backgroundColor = [UIColor grayColor];
        self.imageView_state = [[UIImageView alloc]initWithFrame:CGRectMake(47, 15, 70, 85)];
        self.imageView_state.backgroundColor = [UIColor clearColor];
        [view_back addSubview:self.imageView_state];
        
        self.imageView_labelBack = [[UIImageView alloc]initWithFrame:CGRectMake(12, 127, 126, 19)];
        self.imageView_labelBack.backgroundColor = [UIColor clearColor];
        UIImage* image_labelBack = [UIImage imageNamed:@"voice_cancel_text_bg"];
        UIImage* image_new = [self resizeImage:image_labelBack];
        self.imageView_labelBack.image = image_new;
        [view_back addSubview:self.imageView_labelBack];
        
        self.label_description = [[UILabel alloc]initWithFrame:CGRectMake(0, 129, 151, 15)];
        self.label_description.backgroundColor = [UIColor clearColor];
        self.label_description.textColor = [UIColor whiteColor];
        self.label_description.textAlignment = UITextAlignmentCenter;
        self.label_description.font = [UIFont systemFontOfSize:13];
        [view_back addSubview:self.label_description];
        
        self.prgressView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 111, 100, 9)];
        self.prgressView.backgroundColor = [UIColor clearColor];
        self.prgressView.image = [self resizeImage:[UIImage imageNamed:@"voice_progress_bg"]];
        UIImageView* imageView_currentProgress = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 96, 5)];
        imageView_currentProgress.tag = 10086;
        imageView_currentProgress.backgroundColor = [UIColor clearColor];
        imageView_currentProgress.image = [self resizeImage:[UIImage imageNamed:@"voice_progress"]];
        [self.prgressView addSubview:imageView_currentProgress];
        [view_back addSubview:self.prgressView];
        
        [self.view_toast addSubview:view_back];
        self.view_toast.userInteractionEnabled = NO;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.view_toast];
    
//    [self.window_toast makeKeyWindow];
    self.view_toast.hidden = NO;
    [self display];
}

- (void)setVolumn:(NSInteger)volumn
{
    NSInteger volumn_used = volumn;
    if (MINVOLUMN > volumn)
    {
        volumn_used = MINVOLUMN;
    }
    else if (MAXVOLUMN < volumn)
    {
        volumn_used = MAXVOLUMN;
    }
    _volumn = volumn_used;
    [self display];
}

- (void)setState:(enum StateBannerState)state
{
    _state = state;
    [self display];
}

- (void)setMaxProcessValue:(NSInteger)maxProcessValue
{
    if (0 < maxProcessValue)
    {
        _maxProcessValue = maxProcessValue;
    }
    [self display];
}

- (void)setCurrentProcessValue:(NSInteger)currentProcessValue
{
    if (currentProcessValue > self.maxProcessValue)
    {
        _currentProcessValue = self.maxProcessValue;
    }
    else
    {
        _currentProcessValue = currentProcessValue;
    }
    [self display];
}

- (void)display
{
    if (StateBannerStateCancel == self.state)
    {
        self.label_description.text = @"松开手指，取消录音";
        self.imageView_state.image = [UIImage imageNamed:@"voice_cancel@2x"];
        self.imageView_labelBack.hidden = NO;
        self.prgressView.hidden = YES;
    }
    else if (StateBannerStateNormal == self.state)
    {
        self.label_description.text = @"滑动手指，取消录音";
        self.imageView_state.image = [UIImage imageNamed:[NSString stringWithFormat:@"voice0%d", self.volumn]];
        self.imageView_labelBack.hidden = YES;
        self.prgressView.hidden = NO;
        UIImageView* imageView = (UIImageView*)[self.prgressView viewWithTag:10086];
        float value = 0;
        if (0 >= self.maxProcessValue)
        {
            value = 0;
        }
        else if (0 > self.currentProcessValue)
        {
            value = 0;
        }
        else if (self.currentProcessValue > self.maxProcessValue)
        {
            value = 1;
        }
        else
        {
            value = 1.f * self.currentProcessValue / self.maxProcessValue;
        }
        CGRect frame = imageView.frame;
        frame.size.width = 96 * value;
        imageView.frame = frame;
    }
}
@end
