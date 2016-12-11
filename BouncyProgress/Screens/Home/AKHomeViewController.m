//
//  AKHomeViewController.m
//  BouncyProgress
//
//  Created by Atul Khatri on 11/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKHomeViewController.h"

@interface AKHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *questionButton;

@end

@implementation AKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureUI];
}

- (void)configureUI{
    self.view.backgroundColor= [UIColor colorWithHex:kGenericGreenColor alpha:1.0f];
    [self.questionButton setTitle:[NSLocalizedString(@"home_question", nil) uppercaseString] forState:UIControlStateNormal];
    [self.questionButton.titleLabel setFont:[UIFont fontWithName:kBoldFont size:21.0f]];
    [self.questionButton setBackgroundColor:[UIColor colorWithHex:kWhiteColor alpha:0.8f]];
    [self.questionButton setTitleColor:[UIColor colorWithHex:kGenericGreenColor alpha:1.0f] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
