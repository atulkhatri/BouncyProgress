//
//  AKQuestionLandingVC.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKQuestionLandingVC.h"
#import "AKQuestionVC.h"
#import "AKQuestionModel.h"

typedef enum {
    BAR_BUTTON_TYPE_DONE,
    BAR_BUTTON_TYPE_EXIT,
    BAR_BUTTON_TYPE_LEFT,
    BAR_BUTTON_TYPE_RIGHT
}BarButtonType;

@interface AKQuestionLandingVC () <AKQuestionVCDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation AKQuestionLandingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topMargin= self.topView.frame.size.height;
    
    [self configureUI];

    [self prepareQuestions];
    
    [self refreshBarButtons];
}

- (void)configureUI{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHex:kGenericDarkGreyColor alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:kWhiteColor alpha:1.0f]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:kWhiteColor alpha:1.0f], NSForegroundColorAttributeName,  [UIFont fontWithName:kRegularFont size:20.0f], NSFontAttributeName, nil]];
    
    self.topView.backgroundColor= [UIColor colorWithHex:kGenericDarkGreyColor alpha:1.0f];
    self.pageControl.userInteractionEnabled= NO;
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithHex:kGenericDarkGreenColor alpha:1.0f]];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithHex:kGenericGreenColor alpha:1.0f]];
}

- (void)prepareQuestions{
    self.dataArray= [NSMutableArray new];
    [self.dataArray addObject:[[AKQuestionModel alloc] initWithQuestionText:NSLocalizedString(@"question1_text", nil) minText:NSLocalizedString(@"question1_min_text", nil) maxText:NSLocalizedString(@"question1_max_text", nil)]];
    [self.dataArray addObject:[[AKQuestionModel alloc] initWithQuestionText:NSLocalizedString(@"question2_text", nil) minText:NSLocalizedString(@"question2_min_text", nil) maxText:NSLocalizedString(@"question2_max_text", nil)]];
    [self.dataArray addObject:[[AKQuestionModel alloc] initWithQuestionText:NSLocalizedString(@"question3_text", nil) minText:NSLocalizedString(@"question3_min_text", nil) maxText:NSLocalizedString(@"question3_max_text", nil)]];
    [self.dataArray addObject:[[AKQuestionModel alloc] initWithQuestionText:NSLocalizedString(@"question4_text", nil) minText:NSLocalizedString(@"question4_min_text", nil) maxText:NSLocalizedString(@"question4_max_text", nil)]];
    [self.dataArray addObject:[[AKQuestionModel alloc] initWithQuestionText:NSLocalizedString(@"question5_text", nil) minText:NSLocalizedString(@"question5_min_text", nil) maxText:NSLocalizedString(@"question5_max_text", nil)]];
    [self setupPageViewController];
}

- (void)setupPageViewController{
    self.viewControllers= [NSMutableArray new];
    for(AKQuestionModel* question in self.dataArray){
        AKQuestionVC* vc= [[AKQuestionVC alloc] initWithNibName:@"AKQuestionVC" bundle:nil];
        vc.question= question;
        vc.delegate= self;
        [self.viewControllers addObject:vc];
    }
    [self.pageControl setNumberOfPages:self.dataArray.count];
    [self.pageControl setCurrentPage:0];
    [self reloadPageViewController];
}

- (void)refreshBarButtons{
    //[NSLocalizedString(@"exit", nil) uppercaseString]
    UIBarButtonItem* leftBarButton= nil;
    UIBarButtonItem* rightBarButton= nil;
    if(self.currentIndex == 0){
        // Left button "exit"
        leftBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_EXIT];
        rightBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_RIGHT];
    }else if(self.currentIndex == self.dataArray.count-1){
        // Right button "done"
        rightBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_DONE];
        leftBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_LEFT];
    }else{
        rightBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_RIGHT];
        leftBarButton= [self barButtonWithType:BAR_BUTTON_TYPE_LEFT];
    }
    self.navigationItem.leftBarButtonItem= leftBarButton;
    self.navigationItem.rightBarButtonItem= rightBarButton;
}

- (UIBarButtonItem*)barButtonWithType:(BarButtonType)buttonType{
    UIBarButtonItem* barButton= nil;
    switch (buttonType) {
        case BAR_BUTTON_TYPE_DONE:
            barButton= [self barButtonWithTitle:[NSLocalizedString(@"done", nil) uppercaseString]];
            break;
        case BAR_BUTTON_TYPE_EXIT:
            barButton= [self barButtonWithTitle:[NSLocalizedString(@"exit", nil) uppercaseString]];
            break;
        case BAR_BUTTON_TYPE_LEFT:
            barButton= [self barButtonWithImage:[UIImage imageNamed:@"previous_icon_white"]];
            [barButton setAction:@selector(leftButtonTapped)];
            break;
        case BAR_BUTTON_TYPE_RIGHT:
            barButton= [self barButtonWithImage:[UIImage imageNamed:@"next_icon_white"]];
            [barButton setAction:@selector(rightButtonTapped)];
            break;
    }
    return barButton;
}

- (UIBarButtonItem*)barButtonWithTitle:(NSString*)title{
    UIBarButtonItem* barButton= [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(exitButtonTapped)];
    [barButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:kWhiteColor alpha:1.0f], NSForegroundColorAttributeName,  [UIFont fontWithName:kBoldFont size:20.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    return barButton;
}

- (UIBarButtonItem*)barButtonWithImage:(UIImage*)image{
    UIBarButtonItem* barButton= [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
    return barButton;
}

- (void)leftButtonTapped{
    if(self.currentIndex > 0){
        [self changePageToIndex:self.currentIndex-1 completed:nil];
    }
}

- (void)rightButtonTapped{
    if(self.currentIndex < self.dataArray.count-1){
        [self changePageToIndex:self.currentIndex+1 completed:nil];
    }
}

- (void)exitButtonTapped{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pageChangedToIndex:(NSInteger)index{
    [self.pageControl setCurrentPage:index];
    [self refreshBarButtons];
}

#pragma mark- AKQuestionVCDelegate method
- (void)didChangeProgressForQuestion:(AKQuestionModel*)question{
    // Do something
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
