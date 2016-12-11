//
//  AKVerticalPanRecognizer.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//
//

#import "AKVerticalPanRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface AKVerticalPanRecognizer(){
    BOOL _drag;
    int _moveX;
    int _moveY;
    PanGestureDirection _direction;
}
@end

@implementation AKVerticalPanRecognizer

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    _moveX += prevPoint.x - nowPoint.x;
    _moveY += prevPoint.y - nowPoint.y;
    if (!_drag) {
        if (abs(_moveX) > kDirectionPanThreshold) {
            if (_direction == PAN_GESTURE_DIRECTION_VERTICAL) {
                self.state = UIGestureRecognizerStateFailed;
            }else {
                _drag = YES;
            }
        }else if (abs(_moveY) > kDirectionPanThreshold) {
            if (_direction == PAN_GESTURE_DIRECTION_HORIZONTAL) {
                self.state = UIGestureRecognizerStateFailed;
            }else {
                _drag = YES;
            }
        }
    }
}

- (void)reset {
    [super reset];
    _drag = NO;
    _moveX = 0;
    _moveY = 0;
}

@end
