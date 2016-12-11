//
//  AKBouncyView.h
//  BouncyProgress
//
//  Created by Atul Khatri on 09/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKBouncyView;
@protocol  AKBouncyViewDelegate <NSObject>
@optional
- (void)didChangeProgress:(CGFloat)progress inBouncyView:(AKBouncyView*)view;
@end

IB_DESIGNABLE
@interface AKBouncyView : UIView
@property (nonatomic, strong) IBInspectable UIColor* progressColor;
@property (nonatomic, assign) IBInspectable CGFloat progress;
@property (nonatomic, assign) IBInspectable BOOL tapEnabled;
@property (nonatomic, weak) id <AKBouncyViewDelegate> delegate;
@end
