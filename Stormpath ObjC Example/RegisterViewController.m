//
//  RegisterViewController.m
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/24/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

#import "RegisterViewController.h"
#import "Stormpath-Swift.h"
#import "UIViewController+Alerts.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(exit)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonPressed:(id)sender {
    // Create the registration model
    RegistrationModel *newAccount = [[RegistrationModel alloc] initWithEmail:_emailTextField.text password:_passwordTextField.text];
    newAccount.givenName = _firstNameTextField.text;
    newAccount.surname = _lastNameTextField.text;
    
    // Register the new user
    [[Stormpath sharedSession] register:newAccount completionHandler:^(Account * _Nullable account, NSError * _Nullable error) {
        if(error) {
            [self showAlertWithTitle:@"Error" message:error.localizedDescription];
            return;
        }
        
        // If they need to verify their email, display alert
        if(account.status == AccountStatusUnverified) {
            [self showAlertWithTitle:@"Registration Complete!" message:@"Please check your email to verify your account"];
        }
        // Otherwise, log them in & close registration window
        else {
            [[Stormpath sharedSession] login:newAccount.email password:newAccount.password completionHandler:^(BOOL success, NSError * _Nullable error) {
                if(success) {
                    [self exit];
                }
            }];
        }
    }];
}

- (void)exit {
    [self dismissViewControllerAnimated:true completion:nil];
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
