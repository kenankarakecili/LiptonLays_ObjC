//
//  VisitDetailViewController.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseViewController.h"
#import "Visit.h"

@interface VisitDetailViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) Visit *visitToShow;
@end
