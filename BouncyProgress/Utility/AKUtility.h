//
//  AKUtility.h
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKUtility : NSObject
+ (instancetype)sharedInstance;
- (UIImage*)imageByApplyingTintColor:(UIColor*)color toImage:(UIImage*)image;
@end
