//
//  ContainerViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "ContainerViewController.h"
#import "TabBarCollectionViewCell.h"
#import "VisitsViewController.h"

@interface ContainerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *tabItemsArray;
@property (assign, nonatomic) NSInteger selectedItemIndex;
@end

@implementation ContainerViewController

#pragma LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.tabItemsArray = @[@"Ziyaretlerim",
                           @"Yeni Ziyaret Oluştur",
                           @"Top 10"];
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabItemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TabBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TabBarCellId"
                                                                               forIndexPath:indexPath];
    cell.cellLabel.text = [self.tabItemsArray objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = liptonYellowColour();
    cell.cellLabel.textColor = liptonRedColour();
    if (indexPath.row == self.selectedItemIndex) {
        cell.contentView.backgroundColor = liptonRedColour();
        cell.cellLabel.textColor = liptonYellowColour();
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width / 3, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showViewControllerWithIdentifier:@"VisitsViewControllerId"];
            break;
        case 1:
            [self showViewControllerWithIdentifier:@"NewVisitViewControllerId"];
            break;
        case 2:
            [self showViewControllerWithIdentifier:@"Top10ViewControllerId"];
            break;
    }
    self.title = [self.tabItemsArray objectAtIndex:indexPath.row];
    self.selectedItemIndex = indexPath.row;
    [collectionView reloadData];
}

- (void)showViewControllerWithIdentifier:(NSString *)identifier {
    NSArray *viewsToRemove = self.containerView.subviews;
    for (UIView *view in viewsToRemove) {
        [view removeFromSuperview];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [self addChildViewController:viewController];
    viewController.view.frame = self.containerView.frame;
    [self.containerView addSubview:viewController.view];
}

@end
