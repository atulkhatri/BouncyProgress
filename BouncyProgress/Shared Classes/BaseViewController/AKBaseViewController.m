//
//  AKBaseViewController.m
//  BouncyProgress
//
//  Created by Atul Khatri on 09/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import "AKBaseViewController.h"

@interface AKBaseViewController ()

@end

@implementation AKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self loadContent];
}

- (void)loadContent{
    // Override to make API call here
}

- (void)dealloc{
    self.tableView.delegate= nil;
    self.collectionView.delegate= nil;
}
@end
