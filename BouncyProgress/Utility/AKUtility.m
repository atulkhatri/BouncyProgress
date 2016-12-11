//
//  AKUtility.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKUtility.h"

@implementation AKUtility
+ (instancetype)sharedInstance {
    static id object;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        object = [[self alloc] init];
    });
    return object;
}

- (UIImage*)imageByApplyingTintColor:(UIColor*)color toImage:(UIImage*)image{
    UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, newImage.scale);
    [color set];
    [newImage drawInRect:CGRectMake(0, 0, image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
