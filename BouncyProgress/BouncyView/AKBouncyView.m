//
//  AKBouncyView.m
//  BouncyProgress
//
//  Created by Atul Khatri on 09/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKBouncyView.h"
#import "AKVerticalPanRecognizer.h"

@interface AKBouncyView()
@property (nonatomic, strong) UIView* progressView;
@property (nonatomic, strong) UITapGestureRecognizer* tapRecognizer;
@property (nonatomic, strong) AKVerticalPanRecognizer* panRecognizer;
@end

@implementation AKBouncyView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _progressColor= [UIColor greenColor];
    _progress= 0.0f;
    _tapEnabled= NO;
    _progressView= [[UIView alloc] init];
    _progressView.clipsToBounds= YES;
    self.clipsToBounds= YES;
    [self addSubview:_progressView];
    self.tapRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    self.tapRecognizer.numberOfTapsRequired= 1;
    self.panRecognizer= [[AKVerticalPanRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panRecognizer.direction= PAN_GESTURE_DIRECTION_VERTICAL;
    [self.progressView addGestureRecognizer:self.panRecognizer];
}

- (void)setProgress:(CGFloat)progress{
    if (progress < 0) {
        _progress= 0;
    }else if(progress > 1){
        _progress= 1;
    }else {
        _progress= progress;
    }
    [self refreshView];
}

- (void)setProgressColor:(UIColor *)progressColor{
    if (progressColor != _progressColor) {
        _progressColor = progressColor;
        [self refreshView];
    }
}

- (void)setTapEnabled:(BOOL)tapEnabled{
    _tapEnabled= tapEnabled;
    if(tapEnabled){
        [self addGestureRecognizer:self.tapRecognizer];
    }else{
        [self removeGestureRecognizer:self.tapRecognizer];
    }
}

- (void)drawRect:(CGRect)rect {
    [self refreshView];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)prepareForInterfaceBuilder {
    [self refreshView];
}

- (void)handleTap:(id)sender{
    CGRect layer= self.progressView.frame;
    CGPoint localPoint = [(UITapGestureRecognizer*)sender locationInView:self];
    _progress= (self.frame.size.height-localPoint.y)/self.frame.size.height;
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.progressView.frame= CGRectMake(layer.origin.x, localPoint.y, layer.size.width, self.frame.size.height-localPoint.y);
                     } completion:^(BOOL finished) {
                         [self sendProgressChangedDelegate];
                     }];
}

- (void)handlePan:(id)sender{
    CGPoint localPoint = [(UIPanGestureRecognizer*)sender locationInView:self];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged){
        CGRect layer= self.progressView.frame;
        [UIView animateWithDuration:0.3
                              delay:0.0
             usingSpringWithDamping:0.3
              initialSpringVelocity:0
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             self.progressView.frame= CGRectMake(layer.origin.x, localPoint.y, layer.size.width, self.frame.size.height-localPoint.y);
                         } completion:nil];
        _progress= MIN(1,(self.frame.size.height-localPoint.y)/self.frame.size.height);
        [self sendProgressChangedDelegate];
    }
}

- (void)refreshView{
    CGRect frame= self.bounds;
    CGFloat progressHeight= floorf(MIN(frame.size.height, frame.size.height*self.progress));
    frame.origin.y= frame.size.height-progressHeight;
    frame.size.height= progressHeight;
    self.progressView.frame= frame;
    self.progressView.backgroundColor= self.progressColor;
    [self sendProgressChangedDelegate];
}

- (void)sendProgressChangedDelegate{
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(AKBouncyViewDelegate)]){
        if([self.delegate respondsToSelector:@selector(didChangeProgress:inBouncyView:)]){
            [self.delegate didChangeProgress:_progress inBouncyView:self];
        }
    }
}
@end
