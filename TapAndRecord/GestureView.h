//
//  GestureButton.h
//  test_record
//
//  Created by Renton Lin on 13-11-29.
//  Copyright (c) 2013年 Renton Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GestureView;

@protocol GestureDelegate <NSObject>
@optional
- (void)gestureViewDidBegin:(GestureView*)gestureView withPoint:(CGPoint)point;
- (void)gestureViewDidEnd:(GestureView*)gestureView withPoint:(CGPoint)point;
- (void)gestureView:(GestureView*)gestureView didMoveToPoint:(CGPoint)point;
- (void)gestureViewDidTouchDown:(GestureView *)gestureView;
- (void)gestureViewDidTouchUpInside:(GestureView*)gestureView;
@end

@interface GestureView : UIView

@property (nonatomic, readonly) UIButton* button_showwed;//显示用的BUTTON，抛出来自定义其样式
@property (nonatomic, weak) id<GestureDelegate> delegate;
@end
