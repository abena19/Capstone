//
//  ComposeViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/7/22.
//

#import "ComposeViewController.h"
#import "SceneDelegate.h"
#import "WallFeedController.h"
#import "MyWallViewController.h"
#import "Wall.h"
#import <Parse/Parse.h>
#import "ParseQueryManager.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *lecturePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *locationPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *mealPhoto;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) IBOutlet UITextField *dormLocation;

@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, strong) WallFeedController *wallFeedController;

- (IBAction)didTapPostWall:(UIButton *)sender;

@end

@implementation ComposeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //dismiss keyboard with tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    if ( self.locationPhoto.tag == LocationPhoto) {
        [self setImage:self.locationPhoto withImage:editedImage];
    } else if ( self.lecturePhoto.tag == LecturePhoto) {
        [self setImage:self.lecturePhoto withImage:editedImage];
    } else if (self.mealPhoto.tag == MealPhoto) {
        [self setImage:self.mealPhoto withImage:editedImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) setImage:(UIImageView *)photo withImage:(UIImage *)editedImage {
    [photo setImage:editedImage];
    photo.tag = DefaultState;
}


- (void) tapImageViewHandler {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (IBAction)didTapMealPhoto:(UITapGestureRecognizer *)sender {
    [self tapImageViewHandler];
    self.mealPhoto.tag =  MealPhoto;
}
    

- (IBAction)didTapLocationPhoto:(UITapGestureRecognizer *)sender {
    [self tapImageViewHandler];
    self.locationPhoto.tag = LocationPhoto;
}


- (IBAction)didTapLecturePhoto:(UITapGestureRecognizer *)sender {
    [self tapImageViewHandler];
    self.lecturePhoto.tag = LecturePhoto;
}

- (IBAction)didTapPostWall:(UIButton *)sender {
    self.photoArray = [[NSMutableArray alloc]init];
    [self.photoArray addObject:self.locationPhoto.image];
    [self.photoArray addObject:self.lecturePhoto.image];
    [self.photoArray addObject:self.mealPhoto.image];
    Wall *wall = [Wall postWallImage:self.photoArray withAddress:self.dormLocation.text withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
        } else {
            // move to wall feed if successful
            SceneDelegate *homeSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainString bundle:nil];
            UITabBarController *tabController = [storyboard instantiateViewControllerWithIdentifier:homeTabControllerId];
            homeSceneDelegate.window.rootViewController = tabController;
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:postNotification
                    object:self];
        }
    }];
    self.wallToPass = wall;
    [[ParseQueryManager shared] addToUserWallNumber];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}




@end
