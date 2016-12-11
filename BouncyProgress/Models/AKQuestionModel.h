//
//  AKQuestionModel.h
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKQuestionModel : NSObject
- (instancetype)initWithQuestionText:(NSString*)text minText:(NSString*)minText maxText:(NSString*)maxText;
@property (nonatomic, strong) NSString* questionText;
@property (nonatomic, strong) NSString* minText;
@property (nonatomic, strong) NSString* maxText;
@property (nonatomic, assign) CGFloat progress;  // From 0 to 1
@end
