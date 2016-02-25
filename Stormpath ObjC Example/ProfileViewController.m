//
//  ProfileViewController.m
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/24/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

#import "ProfileViewController.h"
#import "Stormpath-Swift.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *modifiedAtLabel;
@property (weak, nonatomic) IBOutlet UITextView *customDataTextView;
@property (weak, nonatomic) IBOutlet UITextField *hrefTextField;
@property (weak, nonatomic) IBOutlet UITextField *accessTokenTextField;
@property (weak, nonatomic) IBOutlet UITextField *refreshTokenTextField;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _helloLabel.text = [@"Hello, " stringByAppendingString:self.account.fullName];
    _emailLabel.text = [@"Email: " stringByAppendingString:self.account.email];
    _usernameLabel.text = [@"Username: " stringByAppendingString:self.account.username];
    _createdAtLabel.text = [@"Created At: " stringByAppendingString:self.account.createdAt.description];
    _modifiedAtLabel.text = [@"Updated At: " stringByAppendingString:self.account.modifiedAt.description];
    _hrefTextField.text = self.account.href.description;
    _accessTokenTextField.text = Stormpath.sharedSession.accessToken;
    _refreshTokenTextField.text = Stormpath.sharedSession.refreshToken;
    
    
    if(self.account.customData) {
        _customDataTextView.text = [@"Custom Data: " stringByAppendingString:self.account.customData];
    } else {
        _customDataTextView.text = @"Custom Data: nil";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshAccessTokenButtonPressed:(id)sender {
    [[Stormpath sharedSession] refreshAccessToken:^(BOOL success, NSError * _Nullable error) {
        [self viewWillAppear:false];
    }];
}

- (IBAction)logoutButtonPressed:(id)sender {
    [[Stormpath sharedSession] logout];
    [self dismissViewControllerAnimated:NO completion:nil];
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
