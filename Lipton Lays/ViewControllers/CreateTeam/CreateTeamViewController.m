//
//  CreateTeamViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/1/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "CreateTeamViewController.h"

@interface CreateTeamViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CustomField *teamNameField;
@property (weak, nonatomic) IBOutlet CustomField *firstMemberNameField;
@property (weak, nonatomic) IBOutlet CustomField *firstMemberSurnameField;
@property (weak, nonatomic) IBOutlet CustomField *secondMemberNameField;
@property (weak, nonatomic) IBOutlet CustomField *secondMemberSurnameField;
@property (weak, nonatomic) IBOutlet CustomField *thirdMemberNameField;
@property (weak, nonatomic) IBOutlet CustomField *thirdMemberSurnameField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation CreateTeamViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.layer.cornerRadius = 19.f;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowWithNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - Methods
- (void)keyboardDidShowWithNotification:(NSNotification *)notification {
    NSInteger keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                             707 + keyboardHeight);
}

- (void)keyboardWillHide {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                             707);
}

#pragma mark - Textfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.teamNameField) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (textField == self.firstMemberNameField) {
        [self.scrollView setContentOffset:CGPointMake(0, 26) animated:YES];
    } else if (textField == self.firstMemberSurnameField) {
        [self.scrollView setContentOffset:CGPointMake(0, 114) animated:YES];
    } else if (textField == self.secondMemberNameField) {
        [self.scrollView setContentOffset:CGPointMake(0, 202) animated:YES];
    } else if (textField == self.secondMemberSurnameField) {
        [self.scrollView setContentOffset:CGPointMake(0, 292) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 320) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.teamNameField) {
        [self.firstMemberNameField becomeFirstResponder];
    } else if (textField == self.firstMemberNameField) {
        [self.firstMemberSurnameField becomeFirstResponder];
    } else if (textField == self.firstMemberSurnameField) {
        [self.secondMemberNameField becomeFirstResponder];
    } else if (textField == self.secondMemberNameField) {
        [self.secondMemberSurnameField becomeFirstResponder];
    } else if (textField == self.secondMemberSurnameField) {
        [self.thirdMemberNameField becomeFirstResponder];
    } else if (textField == self.thirdMemberNameField) {
        [self.thirdMemberSurnameField becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - IBActions
- (IBAction)registerTeam:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!networkReachable()) {
        showMessageOnly(LINetworkErrorMessage);
        return;
    } else if (!self.teamNameField.text.length || !self.firstMemberNameField.text.length ||
               !self.firstMemberSurnameField.text.length) {
        showMessageOnly(@"Lütfen işaretli alanları eksiksiz giriniz.");
        return;
    }
    Team *teamToAdd = [[Team alloc] initWithName:self.teamNameField.text
                                 firstMemberName:self.firstMemberNameField.text
                              firstMemberSurname:self.firstMemberSurnameField.text
                                secondMemberName:self.secondMemberNameField.text
                             secondMemberSurname:self.secondMemberSurnameField.text
                                 thirdMemberName:self.thirdMemberNameField.text
                              thirdMemberSurname:self.thirdMemberSurnameField.text];
    showLoading(YES);
    [[LiptonAPI sharedAPI] addTeam:teamToAdd completion:^(NSDictionary *responseDictionary) {
        showLoading(NO);
        if (!responseDictionary) {
            showMessageOnly(LIServiceErrorMessage);
        } else if (responseDictionary[@"Message"]) {
            showMessageOnly(responseDictionary[@"Message"]);
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:responseDictionary[@"Token"]
                                                      forKey:LIStoredTokenItemKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"CreateTeamVC_to_ContainerVC" sender:nil];
        }
    }];
}

@end
