//
//  LoginViewController.swift
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/18/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadAccount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: AnyObject) {
        Stormpath.sharedSession.login(emailTextField.text!, password: passwordTextField.text!, completionHandler: loginCompletionHandler)
    }
    
    @IBAction func loginWithFacebook(_ sender: AnyObject) {
        Stormpath.sharedSession.login(socialProvider: .facebook, completionHandler: loginCompletionHandler)
    }
    
    @IBAction func loginWithGoogle(_ sender: AnyObject) {
        Stormpath.sharedSession.login(socialProvider: .google, completionHandler: loginCompletionHandler)
    }
    
    func loginCompletionHandler(_ success: Bool, error: NSError?) {
        guard success else {
            self.showAlert(withTitle: "Error", message: error?.localizedDescription ?? "")
            return
        }
        self.loadAccount(andDisplayFailure: true)
    }
    
    // Helper method that loads the /me endpoint (and optionally displays a
    // failure alert)
    fileprivate func loadAccount(andDisplayFailure failureAlert: Bool = false) {
        Stormpath.sharedSession.me({ (account, error) -> Void in
            guard let account = account , error == nil else {
                if failureAlert {
                    self.showAlert(withTitle: "Error", message: error?.localizedDescription)
                }
                return
            }
            self.showProfileForAccount(account)
        })
    }
    
    // Helper method that takes an account object & shows the profile page
    func showProfileForAccount(_ account: Account) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        profileViewController.account = account
        present(profileViewController, animated: false, completion: nil)
    }
    
    @IBAction func resetPassword(_ sender: AnyObject) {
        Stormpath.sharedSession.resetPassword(emailTextField.text!) { (success, error) -> Void in
            if success {
                self.showAlert(withTitle: "Success", message: "Password Reset Email Sent!")
            } else {
                self.showAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        }
    }
}

// Helper extension to display alerts easily. 
extension UIViewController {
    func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
