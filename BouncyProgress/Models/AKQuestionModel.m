//
//  AKQuestionModel.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKQuestionModel.h"

@implementation AKQuestionModel
- (instancetype)initWithQuestionText:(NSString*)text minText:(NSString*)minText maxText:(NSString*)maxText
{
    self = [super init];
    if (self) {
        _questionText= text;
        _minText= minText;
        _maxText= maxText;
    }
    return self;
}

@end
