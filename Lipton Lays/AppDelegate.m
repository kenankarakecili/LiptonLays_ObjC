//
//  AppDelegate.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/1/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setUI];
    [self setContainerViewControllerIfNecessary];
    [self addLoadingObserver];
    [self registerForPushWithApplication:application];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Parse Push
- (void)registerForPushWithApplication:(UIApplication *)application {
    [Parse setApplicationId:@"T0QN7g3de2tEgNBMJbis7oPgi1t3B3JE93NXIqOu"
                  clientKey:@"gqL9mTOgGJRbCCimkWVKaDP90ZIDJdK2Jaq76sjb"];
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

#pragma Methods
- (void)setUI {
    UIImage *navBarBackgroundImage = [[UIImage imageNamed:@"navbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                                                                    resizingMode:UIImageResizingModeStretch];
    [[UINavigationBar appearance] setBackgroundImage:navBarBackgroundImage
                                       forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].barTintColor = liptonRedColour();
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : liptonRedColour()};
}

- (void)setContainerViewControllerIfNecessary {
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:LIStoredTokenItemKey];
    if (token) {
        UIStoryboard *storyboard = self.window.rootViewController.storyboard;
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ContainerViewControllerId"];
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
}

- (void)addLoadingObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLoading:)
                                                 name:LIShowLoadingNotificationKey
                                               object:nil];
}

- (void)showLoading:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    BOOL show = [info[@"show"] boolValue];
    UIView *bgView = [self.window viewWithTag:1234];
    if (bgView == nil) {
        bgView = [[UIView alloc] initWithFrame:self.window.frame];
        bgView.tag = 1234;
        bgView.backgroundColor = [UIColor clearColor];
        UIView *bgColor = [[UIView alloc] initWithFrame:bgView.frame];
        bgColor.alpha = 0.7;
        bgColor.backgroundColor = [UIColor blackColor];
        [bgView addSubview:bgColor];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 180, 120)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityIndicator.backgroundColor = [UIColor blackColor];
        activityIndicator.layer.cornerRadius = 6.f;
        activityIndicator.layer.masksToBounds = YES;
        [activityIndicator startAnimating];
        [bgView addSubview:activityIndicator];
        UILabel *pleaseWait = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 180, 30)];
        pleaseWait.backgroundColor = [UIColor clearColor];
        pleaseWait.textAlignment = NSTextAlignmentCenter;
        pleaseWait.text = @"Yükleniyor..";
        pleaseWait.font = [UIFont systemFontOfSize:13];
        pleaseWait.textColor = [UIColor whiteColor];
        [activityIndicator addSubview:pleaseWait];
        activityIndicator.center = bgView.center;
        [self.window addSubview:bgView];
    }
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        bgView.alpha = show;
    } completion:^(BOOL finished) {
    }];
}

@end
