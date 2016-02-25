//
//  UIViewController+Alerts.m
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/24/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

// Helper category extension to display alerts easily.
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end