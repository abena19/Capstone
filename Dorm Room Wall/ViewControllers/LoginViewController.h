//
//  LoginViewController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/5/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) NSString *userId;

- (IBAction)loginUser:(id)sender;

- (IBAction)registerUser:(id)sender;
- (IBAction)registerUserFB:(id)sender;
- (IBAction)registerUserGoogle:(id)sender;

@end

NS_ASSUME_NONNULL_END
