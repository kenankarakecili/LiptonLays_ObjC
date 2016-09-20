//
//  VisitsViewController.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseViewController.h"

@interface VisitsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSString *titleToShow;
@property (strong, nonatomic) NSArray *visitsToShowArray;
@end
