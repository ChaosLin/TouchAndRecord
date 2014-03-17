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

#warning 这个类还可以进一步抽象成两个类，抽象成一个管理怎么显示、一个提供资源，这样在其它情况下，可以子类化资源类以达到定制新的效果的目的,甚至显示类显示的逻辑也可以抛给资源类
@interface StateBanner : NSObject

+ (StateBanner*)sharedInstance;
+ (void)destroy;

- (void)show;//显示出来

@property (nonatomic, assign) enum StateBannerState state;
@property (nonatomic, assign) NSInteger volumn;
@property (nonatomic, assign) NSInteger maxProcessValue;
@property (nonatomic, assign) NSInteger currentProcessValue;
@end
