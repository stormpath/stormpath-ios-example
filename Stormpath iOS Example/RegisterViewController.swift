//
//  RegisterViewController.swift
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/18/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "exit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: AnyObject) {
        // Create the registration model
        let newUser = RegistrationModel(email: emailTextField.text!, password: passwordTextField.text!)
        newUser.givenName = firstNameTextField.text!
        newUser.surname = lastNameTextField.text!
        
        // Register the new user
        Stormpath.sharedSession.register(newUser) { (account, error) -> Void in
            guard let account = account where error == nil else {
                self.showAlert(withTitle: "Error", message: error?.localizedDescription)
                return
            }
            
            // If they need to verify their email, display alert
            if account.status == .Unverified {
                self.showAlert(withTitle: "Registration Complete!", message: "Please check your email to verify your account")
            }
            // Otherwise, log them in & close registration window
            else {
                Stormpath.sharedSession.login(newUser.email, password: newUser.password, completionHandler: { (success, error) -> Void in
                    if success {
                        self.exit()
                    }
                })
            }
        }
    }
    
    func exit() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
