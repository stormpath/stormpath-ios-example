//
//  ProfileViewController.h
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/24/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stormpath-Swift.h"

@class Account;

@interface ProfileViewController : UIViewController

@property SPHAccount *account;

@end
