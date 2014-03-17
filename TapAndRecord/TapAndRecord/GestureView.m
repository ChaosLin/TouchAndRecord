//
//  GestureButton.m
//  test_record
//
//  Created by Renton Lin on 13-11-29.
//  Copyright (c) 2013年 Renton Lin. All rights reserved.
//

#import "GestureView.h"
@interface GestureView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;
@end

@implementation GestureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _button_showwed = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_showwed.frame = self.bounds;
        _button_showwed.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_button_showwed];
        [_button_showwed addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_button_showwed addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_button_showwed addTarget:self action:@selector(buttonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGestureGot:)];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)buttonTouchDown:(id)sender
{
    DLog(@"%@", NSStringFromSelector(_cmd));
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureViewDidTouchDown:)])
    {
        [self.delegate gestureViewDidTouchDown:self];
    }

}

- (void)buttonTouchUpInside:(id)sender
{
    DLog(@"%@", NSStringFromSelector(_cmd));
    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureViewDidTouchUpInside:)])
    {
        [self.delegate gestureViewDidTouchUpInside:self];
    }
}

- (void)buttonTouchUpOutside:(id)sender
{
    DLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark - GestureRecognizerMethod
- (void)dragGestureGot:(id)sender
{
    UIGestureRecognizer* gestureReconizer = (UIGestureRecognizer*)sender;
    CGPoint point = [gestureReconizer locationInView:self];
    if (UIGestureRecognizerStateBegan == gestureReconizer.state)
    {
        self.button_showwed.selected = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(gestureViewDidBegin:withPoint:)])
        {
            [self.delegate gestureViewDidBegin:self withPoint:point];
        }
    }
    else if (UIGestureRecognizerStateChanged == gestureReconizer.state)
    {
        self.button_showwed.selected = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(gestureView:didMoveToPoint:)])
        {
//            NSLog(@"%@", NSStringFromCGPoint(point));
            [self.delegate gestureView:self didMoveToPoint:point];
        }
    }
    else if (UIGestureRecognizerStateEnded == gestureReconizer.state)
    {
        self.button_showwed.selected = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(gestureViewDidEnd:withPoint:)])
        {
            [self.delegate gestureViewDidEnd:self withPoint:point];
        }
    }
}
@end
