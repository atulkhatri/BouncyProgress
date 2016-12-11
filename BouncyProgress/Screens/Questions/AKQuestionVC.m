//
//  AKQuestionVC.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKQuestionVC.h"
#import "AKBouncyView.h"

#define kMinFontSize 15.0f
#define kMaxFontSize 34.0f

@interface AKQuestionVC () <UIGestureRecognizerDelegate, AKBouncyViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet AKBouncyView *progressView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation AKQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configureUI];
}

- (void)configureUI{
    self.bottomView.backgroundColor= [UIColor colorWithHex:kGenericDarkGreyColor alpha:1.0f];
    self.progressView.backgroundColor= [UIColor colorWithHex:kGenericGreyColor alpha:1.0f];
    self.progressView.progressColor= [UIColor colorWithHex:kGenericGreenColor alpha:1.0f];
    self.progressView.tapEnabled= YES;

    self.minLabel.font= [UIFont fontWithName:kBoldFont size:kMaxFontSize];
    self.minLabel.textColor= [UIColor colorWithHex:kWhiteColor alpha:1.0f];
    self.maxLabel.font= [UIFont fontWithName:kBoldFont size:kMinFontSize];
    self.maxLabel.textColor= [UIColor colorWithHex:kWhiteColor alpha:1.0f];
    self.questionLabel.font= [UIFont fontWithName:kBoldFont size:20.0f];
    self.questionLabel.textColor= [UIColor colorWithHex:kGenericLightGreyColor alpha:1.0f];
    
    self.minLabel.text= [self.question.minText uppercaseString];
    self.maxLabel.text= [self.question.maxText uppercaseString];
    self.questionLabel.text= self.question.questionText;
    
    self.progressView.delegate= self;
}

#pragma mark- AKBouncyViewDelegate
- (void)didChangeProgress:(CGFloat)progress inBouncyView:(AKBouncyView *)view{
    self.question.progress= progress;
    CGFloat maxSize= ((kMaxFontSize-kMinFontSize)*progress)+kMinFontSize;
    CGFloat minSize= ((kMaxFontSize-kMinFontSize)*(1.0f-progress))+kMinFontSize;
    self.maxLabel.font= [UIFont fontWithName:kBoldFont size:maxSize];
    self.minLabel.font= [UIFont fontWithName:kBoldFont size:minSize];
    self.maxLabel.textColor= [UIColor colorWithHex:kWhiteColor alpha:MAX(0.4,progress)];
    self.minLabel.textColor= [UIColor colorWithHex:kWhiteColor alpha:MAX(0.4,1.0f-progress)];
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(AKQuestionVCDelegate)]){
        if([self.delegate respondsToSelector:@selector(didChangeProgressForQuestion:)]){
            [self.delegate didChangeProgressForQuestion:self.question];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
