//
//  LoginViewController.swift
//  SimpleDemo
//
//  Created by Adis on 03/12/15.
//  Copyright © 2015 Stormpath. All rights reserved.
//

import UIKit
import Stormpath
import TextFieldEffects
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: HoshiTextField!
    @IBOutlet weak var usernameTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        self.navigationController?.navigationBar.translucent = false
        
        self.urlTextField.placeholder = "Your API URL goes here"

        self.usernameTextField.placeholder = "Username"
        self.passwordTextField.placeholder = "Password"
        
        self.urlTextField.becomeFirstResponder()
        
        // Set up Stormpath
        Stormpath.setUpWithURL("http://localhost:3000")
        Stormpath.setLogLevel(.Verbose)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonActionHandler() {
        // This is only if you changed the URL in the textfield, not a regular use-case
        if let urlString = self.urlTextField.text {
            Stormpath.setUpWithURL(urlString)
        }
        
        guard self.usernameTextField.text?.isEmpty == false && self.passwordTextField.text?.isEmpty == false else {
            let alertController = UIAlertController.init(title: "Error", message: "Please enter your username and password before logging in!", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: .Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        SVProgressHUD.show()
        
        Stormpath.login(username: self.usernameTextField.text!, password: self.passwordTextField.text!) { (accessToken, error) -> Void in
            if error == nil {
                SVProgressHUD.showSuccessWithStatus("Done!")
                
                let menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController")
                self.navigationController?.pushViewController(menuViewController!, animated: true)
            } else {
                SVProgressHUD.showErrorWithStatus(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func registerButtonActionHandler() {
        // This is only if you changed the URL in the textfield, not a regular use-case
        if let urlString = self.urlTextField.text {
            Stormpath.setUpWithURL(urlString)
        }
        
        let registerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController")
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }

}

