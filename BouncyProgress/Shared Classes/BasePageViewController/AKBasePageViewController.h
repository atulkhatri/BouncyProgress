//
//  AKBasePageViewController.h
//  BouncyProgress
//
//  Created by Atul Khatri on 09/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKBaseViewController.h"
#import "AKPageViewController.h"

@interface AKBasePageViewController : AKBaseViewController
@property (strong, nonatomic) AKPageViewController *pageController;
@property (nonatomic, strong) UIView* pageControllerContainerView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) AKBaseViewController* currentViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat topMargin;
- (void)reloadPageViewController;
- (void)addViewControllers:(NSArray*)viewControllers;
- (void)changePageToIndex:(NSInteger)index completed:(void (^)(BOOL success))completed;
- (void)pageChangedToIndex:(NSInteger)index;
- (void)scrollPageViewToLeft:(void (^)(BOOL sucess))completed;
- (void)scrollPageViewToRight:(void (^)(BOOL sucess))completed;
@end
