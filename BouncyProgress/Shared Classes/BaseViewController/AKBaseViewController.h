//
//  AKBaseViewController.m
//  BouncyProgress
//
//  Created by Atul Khatri on 09/12/16.
//  Copyright © 2016 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* sectionArray;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) AKBaseViewController* parentController;
@end
