//
//  VisitDetailViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "VisitDetailViewController.h"
#import "PhotoDetailViewController.h"
#import "PhotoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface VisitDetailViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *imageArray;
@property (copy, nonatomic) NSString *selectedPhotoUrl;
@end

@implementation VisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.visitToShow.locationName;
    [self getVisitDetails];
}

#pragma mark - Methods
- (void)getVisitDetails {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",
                           LIBaseRequest,
                           LIGetVisitDetailRequest,
                           self.visitToShow.locationId];
    showLoading(YES);
    [[LiptonAPI sharedAPI] getRequestWithUrlString:urlString completion:^(id responseObject) {
        showLoading(NO);
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in responseObject[@"LocationImage"]) {
            NSString *imageUrlString = dictionary[@"Image"];
            [tempArray addObject:imageUrlString];
        }
        self.imageArray = [tempArray copy];
        [self.collectionView reloadData];
    }];
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat edgeLength = (CGRectGetWidth(self.collectionView.frame) / 2) - 10;
    return CGSizeMake(edgeLength, edgeLength);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VisitDetailCollectionViewCellId"
                                                                              forIndexPath:indexPath];
    NSURL *imageURL = [self.imageArray objectAtIndex:indexPath.row];
    [cell.cellImageView sd_setImageWithURL:imageURL];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedPhotoUrl = [self.imageArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"VisitDetailVC_to_PhotoDetailVC" sender:nil];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VisitDetailVC_to_PhotoDetailVC"]) {
        PhotoDetailViewController *photoDetailViewController = (PhotoDetailViewController *)segue.destinationViewController;
        photoDetailViewController.photoUrlString = self.selectedPhotoUrl;
    }
}

@end
