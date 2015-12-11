//
//  MenuViewController.swift
//  SimpleDemo
//
//  Created by Adis on 03/12/15.
//  Copyright © 2015 Stormpath. All rights reserved.
//

import UIKit

import Stormpath
import TextFieldEffects
import SVProgressHUD

class MenuViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var usernameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    @IBOutlet weak var tokenTextField: HoshiTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hi!"
        
        let logoutBarButton: UIBarButtonItem = UIBarButtonItem.init(title: "Log out", style: .Done, target: self, action: Selector("logOutActionHandler"))
        self.navigationItem.rightBarButtonItem = logoutBarButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // We'll trim the token down because it's huge, and most of the first part is the same, so just show the last 10 characters
        self.tokenTextField.text = "..." + Stormpath.accessToken!.substringFromIndex(Stormpath.accessToken!.endIndex.advancedBy(-10))
        
        // Fetch some user data
        self.refreshDataActionHandler("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func logOutActionHandler() {
        Stormpath.logout { (error) -> Void in
            // Maybe some error handling here? Use this only if you have to
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // This is the only method in the SDK itself that can fail due to access_token being invalid.
    @IBAction func refreshDataActionHandler(sender: AnyObject) {
        SVProgressHUD.show()
        
        Stormpath.me { (userData, error) -> Void in
            
            if error == nil {
                guard userData != nil else {
                    SVProgressHUD.showErrorWithStatus("No data received!")
                    return
                }
                
                // Show user data from the received dictionary
                self.showUserDataWithDictionary(userData!)
                SVProgressHUD.showSuccessWithStatus("Done!")
            } else {
                // There was some kind of an error
                
                // This is the error for invalid access_token usually. At this point, it's worth to attempt to refresh the token and retry the request without bothering the users
                // In the future, we'll look into making this as seamless as possible
                //
                // NOTE: This works only if you have refresh_token enabled in your application
                if error?.code == 401 {
                    Stormpath.refreshAccesToken(completionHandler: { (accessToken, error) -> Void in
                        if error == nil {
                            // All cool, we got a new access_token, let's try the refresh again
                            
                            Stormpath.me(completionHandler: { (userDictionary, error) -> Void in
                                if error == nil {
                                    // Great, it worked, the user never noticed his token expired
                                    self.showUserDataWithDictionary(userData!)
                                    SVProgressHUD.showSuccessWithStatus("Done!")
                                } else {
                                    // Although you might have been tempted to make a recursion, the failure here means you have to log out the user and prompt them to log in again
                                    SVProgressHUD.showErrorWithStatus("Please log in again!")
                                    self.logOutActionHandler()
                                }
                            })
                        } else {
                            // Well, the failure here means that either the refresh_token is no longer valid, or that it's not enabled at all, log the user out and ask for credentials
                            SVProgressHUD.showErrorWithStatus("Please log in again!")
                            self.logOutActionHandler()
                        }
                    })
                } else {
                    // This is your custom flavored error handling, something else went wrong and it's probably a good idea to let the users know what's going on
                    SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
        }
    }
    
    // This method just forces the refresh of access_token, not something users should be doing directly
    @IBAction func refreshTokenActionHandler(sender: AnyObject) {
        SVProgressHUD.show()
        
        Stormpath.refreshAccesToken { (accessToken, error) -> Void in
            if error == nil {
                SVProgressHUD.showSuccessWithStatus("Done!")
                self.tokenTextField.text = "..." + Stormpath.accessToken!.substringFromIndex(Stormpath.accessToken!.endIndex.advancedBy(-10))
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
            }
        }
    }
    
    // MARK: Helpers
    
    func showUserDataWithDictionary(userDictionary: NSDictionary) {
        // Extract the user data
        if let fullName: String? = userDictionary["fullName"] as? String {
            self.nameTextField.text = fullName
        }
        
        if let username: String? = userDictionary["username"] as? String {
            self.usernameTextField.text = username
        }
        
        if let email: String? = userDictionary["email"] as? String {
            self.emailTextField.text = email
        }
    }

}
