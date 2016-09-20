//
//  AddVisitRequest.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "AddVisitRequest.h"

@implementation AddVisitRequest

- (instancetype)initWithVisit:(Visit *)visit {
    self = [super initWithMethodType:@"POST"];
    if (self) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", LIBaseRequest, LIAddVisitRequest];
        self.URL = [NSURL URLWithString:urlString];
        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:LIStoredTokenItemKey];
        id photoArrayJson = @[];
        if (visit.imageArray.count > 0) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < visit.imageArray.count; i++) {
                UIImage *imageToConvert = [visit.imageArray objectAtIndex:i];
                NSString *imageString = [UIImagePNGRepresentation(imageToConvert)
                                         base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [tempArray addObject:@{@"Base64String" : imageString}];
            }
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArray
                                                               options:kNilOptions
                                                                 error:nil];
            photoArrayJson = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:kNilOptions
                                                               error:nil];
        }
        
        NSDictionary *dictionary = @{
                                     @"Token" : token,
                                     @"LocationName" : [NSString stringWithFormat:@"%@", visit.locationName],
                                     @"LocationImage": photoArrayJson
                                     };
        self.HTTPBody = [self dataFromObject:dictionary];
        NSLog(@"%@", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]);
    }
    return self;
}

@end
