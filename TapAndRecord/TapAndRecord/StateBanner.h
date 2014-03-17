//
//  StateShowView.h
//  test_record
//
//  Created by Renton Lin on 13-11-29.
//  Copyright (c) 2013年 Renton Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

enum StateBannerState {
    StateBannerStateNormal = 0,
    StateBannerStateCancel = 1
    };

#warning 在具体地情况下用什么图片也可以抛到外面
@interface StateBanner : NSObject

+ (StateBanner*)sharedInstance;
+ (void)destroy;

- (void)show;//显示出来

@property (nonatomic, assign) enum StateBannerState state;
@property (nonatomic, assign) NSInteger volumn;
@property (nonatomic, assign) NSInteger maxProcessValue;
@property (nonatomic, assign) NSInteger currentProcessValue;
@end
