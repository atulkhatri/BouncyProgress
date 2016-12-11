//
//  AKQuestionVC.h
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKBaseViewController.h"
#import "AKQuestionModel.h"

@protocol AKQuestionVCDelegate <NSObject>
@optional
- (void)didChangeProgressForQuestion:(AKQuestionModel*)question;
@end

@interface AKQuestionVC : AKBaseViewController
@property (nonatomic, strong) AKQuestionModel* question;
@property (nonatomic, weak) id <AKQuestionVCDelegate> delegate;
@end
