//
//  Top10ViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "Top10ViewController.h"
#import "VisitsViewController.h"
#import "Top10TableViewCell.h"

@interface Top10ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *top10Array;
@property (strong, nonatomic) NSArray *visitsToShowArray;
@property (copy, nonatomic) NSString *selectedTeamName;
@end

@implementation Top10ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setTableViewBackgroundView];
    [self fetchTop10List];
}

#pragma mark - Methods
- (void)setTableViewBackgroundView {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.tableView.frame];
    backgroundImageView.image = [UIImage imageNamed:@"background"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = backgroundImageView;
}

- (void)fetchTop10List {
    if (!networkReachable()) {
        showMessageOnly(LINetworkErrorMessage);
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@", LIBaseRequest, LIGetTop10Request];
    showLoading(YES);
    [[LiptonAPI sharedAPI] getRequestWithUrlString:urlString completion:^(id responseObject) {
        showLoading(NO);
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in responseObject) {
            [tempArray addObject:dictionary];
        }
        self.top10Array = [tempArray copy];
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.top10Array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Top10TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Top10TableViewCellId"];
    NSDictionary *dictionary = [self.top10Array objectAtIndex:indexPath.row];
    cell.cellNumberLabel.text = [NSString stringWithFormat:@"%@", dictionary[@"Order"]];
    cell.cellNameLabel.text = dictionary[@"Team"];
    cell.cellVisitsLabel.text = dictionary[@"Count"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!networkReachable()) {
        showMessageOnly(LINetworkErrorMessage);
        return;
    }
    NSDictionary *dictionary = [self.top10Array objectAtIndex:indexPath.row];
    self.selectedTeamName = dictionary[@"Team"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", LIBaseRequest, LIGetLocationRequest, dictionary[@"Token"]];
    showLoading(YES);
    [[LiptonAPI sharedAPI] getRequestWithUrlString:urlString completion:^(id responseObject) {
        showLoading(NO);
        self.visitsToShowArray = responseObject;
        [self performSegueWithIdentifier:@"Top10VC_to_VisitsVC" sender:nil];
    }];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Top10VC_to_VisitsVC"]) {
        VisitsViewController *visitsViewController = (VisitsViewController *)segue.destinationViewController;
        visitsViewController.titleToShow = self.selectedTeamName;
        visitsViewController.visitsToShowArray = self.visitsToShowArray;
    }
}

@end
