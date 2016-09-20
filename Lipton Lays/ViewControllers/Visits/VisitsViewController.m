//
//  VisitsViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "VisitsViewController.h"
#import "VisitDetailViewController.h"
#import "VisitTableViewCell.h"
#import "Visit.h"

@interface VisitsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noVisitLabel;

@property (strong, nonatomic) Visit *visit;
@property (strong, nonatomic) NSArray *visitsArray;
@end

@implementation VisitsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setTableViewBackgroundView];
    
    if (self.visitsToShowArray) {
        [self getVisits];
        self.title = self.titleToShow;
    } else {
        [self fetchVisits];
    }
}

#pragma mark - Methods
- (void)setTableViewBackgroundView {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.tableView.frame];
    backgroundImageView.image = [UIImage imageNamed:@"background"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = backgroundImageView;
}

- (void)fetchVisits {
    if (!networkReachable()) {
        showMessageOnly(LINetworkErrorMessage);
        return;
    }
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:LIStoredTokenItemKey];
    if (token) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@", LIBaseRequest, LIGetLocationRequest, token];
        showLoading(YES);
        [[LiptonAPI sharedAPI] getRequestWithUrlString:urlString completion:^(id responseObject) {
            showLoading(NO);
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionary in responseObject) {
                Visit *visit = [[Visit alloc] init];
                [visit setValuesForKeysWithDictionary:dictionary];
                [tempArray addObject:visit];
            }
            self.visitsArray = [tempArray copy];
            [self.tableView reloadData];
            self.noVisitLabel.hidden = self.visitsArray.count > 0 ? YES : NO;
        }];
    }
}

- (void)getVisits {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.visitsToShowArray) {
        Visit *visit = [[Visit alloc] init];
        [visit setValuesForKeysWithDictionary:dictionary];
        [tempArray addObject:visit];
    }
    self.visitsArray = [tempArray copy];
    [self.tableView reloadData];
    self.noVisitLabel.hidden = self.visitsArray.count > 0 ? YES : NO;
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.visitsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VisitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitTableViewCellId"];
    BOOL makeGray = indexPath.row % 2;
    cell.contentView.backgroundColor = [UIColor clearColor];
    if (makeGray) {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:.97f alpha:.7f];
    }
    self.visit = [self.visitsArray objectAtIndex:indexPath.row];
    cell.cellTimeLabel.text = self.visit.time;
    cell.cellPlaceNameLabel.text = self.visit.locationName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.visit = [self.visitsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"VisitsVC_to_VisitDetailVC" sender:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.visitsToShowArray) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.visit = [self.visitsArray objectAtIndex:indexPath.row];
    NSMutableArray *tempArray = [self.visitsArray mutableCopy];
    for (Visit *visitToDelete in tempArray) {
        if (visitToDelete.locationId.integerValue == self.visit.locationId.integerValue) {
            NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:LIStoredTokenItemKey];
            NSString *urlString = [NSString stringWithFormat:@"%@%@", LIBaseRequest, getDeleteVisitRequest(visitToDelete.locationId, token)];
            showLoading(YES);
            [[LiptonAPI sharedAPI] getRequestWithUrlString:urlString completion:^(id responseObject) {
                showLoading(NO);
                [tempArray removeObject:visitToDelete];
                self.visitsArray = [tempArray copy];
                [tableView deleteRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationFade];
                self.noVisitLabel.hidden = self.visitsArray.count > 0 ? YES : NO;
            }];
            break;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Sil";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VisitsVC_to_VisitDetailVC"]) {
        VisitDetailViewController *visitDetailViewController = (VisitDetailViewController *)segue.destinationViewController;
        visitDetailViewController.visitToShow = self.visit;
    }
}

@end
