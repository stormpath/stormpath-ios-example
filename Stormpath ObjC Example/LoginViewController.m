//
//  LoginViewController.m
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/24/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "Stormpath-Swift.h"
#import "UIViewController+Alerts.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadAccountWithFailureAlert:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [[SPHStormpath sharedSession] loginWithUsername:self.emailTextField.text password:self.passwordTextField.text callback:^(BOOL success, NSError * _Nullable error) {
        [self loginCompletionHandler:success error:error];
    }];
}

- (IBAction)loginWithFacebookButtonPressed:(id)sender {
    [[SPHStormpath sharedSession] loginWithProvider:SPHProviderFacebook callback:^(BOOL success, NSError * _Nullable error) {
        [self loginCompletionHandler:success error:error];
    }];
}

- (IBAction)loginWithGoogleButtonPressed:(id)sender {
    [[SPHStormpath sharedSession] loginWithProvider:SPHProviderGoogle callback:^(BOOL success, NSError * _Nullable error) {
        [self loginCompletionHandler:success error:error];
    }];
}

- (void)loginCompletionHandler:(BOOL)success error:(NSError *)error {
    if(error) {
        [self showAlertWithTitle:@"Error" message:error.localizedDescription];
        return;
    }
    [self loadAccountWithFailureAlert:YES];
}

// Helper method that loads the /me endpoint (and optionally displays a
// failure alert)
- (void)loadAccountWithFailureAlert:(BOOL)failureAlert {
    [[SPHStormpath sharedSession] meWithCallback:^(SPHAccount * _Nullable account, NSError * _Nullable error) {
        if(error) {
            if(failureAlert) {
                [self showAlertWithTitle:@"Error" message:error.localizedDescription];
            }
            return;
        }
        [self showProfileForAccount:account];
    }];
}

// Helper method that takes an account object & shows the profile page
- (void)showProfileForAccount:(SPHAccount *)account {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    profileViewController.account = account;
    [self presentViewController:profileViewController animated:NO completion:nil];
}

- (IBAction)resetButtonPressed:(id)sender {
    [[SPHStormpath sharedSession] resetPasswordWithEmail:_emailTextField.text callback:^(BOOL success, NSError * _Nullable error) {
        if(success) {
            [self showAlertWithTitle:@"Success" message:@"Password Reset Email Sent!"];
        } else {
            [self showAlertWithTitle:@"Error" message:error.localizedDescription];
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
