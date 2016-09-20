//
//  NewVisitViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "NewVisitViewController.h"
#import "PhotoCollectionViewCell.h"

@interface NewVisitViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *locationNameField;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (retain, nonatomic) NSMutableArray *photoMutableArray;
@property (retain, nonatomic) UITapGestureRecognizer *tapGesture;
@end

@implementation NewVisitViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoMutableArray = [[NSMutableArray alloc] init];
    self.addPhotoButton.layer.cornerRadius = 18.f;
    self.saveButton.layer.cornerRadius = 18.f;
    self.locationNameField.layer.cornerRadius = 2.f;
    self.collectionView.layer.cornerRadius = 2.f;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:.98f alpha:1.f];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(dismissKeyboard)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(keyboardDidShow)
                                                   name:UIKeyboardDidShowNotification
                                                 object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - Methods
- (void)keyboardDidShow {
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:self.tapGesture];
}

- (void)deletePhoto:(UIButton *)sender {
    [self.photoMutableArray removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
}

#pragma mark - Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoMutableArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCelId"
                                                                                   forIndexPath:indexPath];
    cell.cellImageView.image = [self.photoMutableArray objectAtIndex:indexPath.row];
    cell.cellDeleteButton.tag = indexPath.row;
    [cell.cellDeleteButton addTarget:self
                              action:@selector(deletePhoto:)
                    forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = nil;
        if (info[UIImagePickerControllerEditedImage]) {
            image = info[UIImagePickerControllerEditedImage];
            image = [image normalizedImageWithRatio:.5f];
        } else {
            image = info[UIImagePickerControllerOriginalImage];
            image = [image normalizedImageWithRatio:.2f];
        }
        [self.photoMutableArray addObject:image];
        [self.collectionView reloadData];
    }];
}

#pragma mark - IBActions
- (IBAction)addPhoto:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        showMessageOnly(@"Cihazınızın kamerası aktif değil.");
        return;
    } else if (self.photoMutableArray.count == 5) {
        showMessageOnly(@"En fazla 5 adet fotoğraf eklenebilmektedir.");
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Vazgeç"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Fotoğraf Çek", @"Galeriden Seç", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (IBAction)addLocation:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!networkReachable()) {
        showMessageOnly(LINetworkErrorMessage);
        return;
    } else if (!self.locationNameField.text.length) {
        showMessageOnly(@"Lütfen nokta adı giriniz.");
        return;
    } else if (self.photoMutableArray.count < 1) {
        showMessageOnly(@"Lütfen en az 1 fotoğraf çekiniz.");
        return;
    }
    Visit *visit = [[Visit alloc] init];
    visit.locationName = self.locationNameField.text;
    visit.imageArray = [self.photoMutableArray copy];
    showLoading(YES);
    [[LiptonAPI sharedAPI] addVisit:visit completion:^(NSDictionary *responseDictionary) {
        showLoading(NO);
        if (responseDictionary[@"Message"]) {
            showMessageOnly(responseDictionary[@"Message"]);
        } else if ([responseDictionary[@"Status"] isEqualToString:@"Success"]) {
            showMessageOnly(@"Ziyaret başarılı bir şekilde eklendi.");
            self.photoMutableArray = [[NSMutableArray alloc] init];
            self.locationNameField.text = nil;
            [self.collectionView reloadData];
        } else {
            showMessageOnly(LIServiceErrorMessage);
        }
    }];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self showCameraPicker];
    } else if (buttonIndex == 1) {
        [self showGaleryPicker];
    }
}

- (void)showCameraPicker {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController
                       animated:YES
                     completion:nil];
}

- (void)showGaleryPicker {
    UIImagePickerController *imagePickerController = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController
                           animated:YES
                         completion:nil];
    }
}

@end
