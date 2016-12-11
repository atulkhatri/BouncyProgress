//
//  AKVerticalPanRecognizer.h
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

int const static kDirectionPanThreshold = 15;

typedef enum {
    PAN_GESTURE_DIRECTION_VERTICAL,
    PAN_GESTURE_DIRECTION_HORIZONTAL
} PanGestureDirection;

@interface AKVerticalPanRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) PanGestureDirection direction;

@end
