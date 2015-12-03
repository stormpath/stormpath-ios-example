//
//  RegisterViewController.swift
//  SimpleDemo
//
//  Created by Adis on 03/12/15.
//  Copyright © 2015 Stormpath. All rights reserved.
//

import UIKit

import Stormpath
import TextFieldEffects
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: HoshiTextField!
    @IBOutlet weak var lastNameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Register"
        
        self.firstNameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerActionHandler() {
        guard self.firstNameTextField.text?.isEmpty == false
            && self.lastNameTextField.text?.isEmpty == false
            && self.emailTextField.text?.isEmpty == false
            && self.passwordTextField.text?.isEmpty == false else {
            let alertController = UIAlertController.init(title: "Error", message: "Please fill all fields!", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: .Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        let userDictionary = [
            "givenName": self.firstNameTextField.text!,
            "surname": self.lastNameTextField.text!,
            "email": self.emailTextField.text!,
            "password": self.passwordTextField.text!
        ]
        
        SVProgressHUD.show()
        
        Stormpath.register(userDictionary: userDictionary) { (userDictionary, error) -> Void in
            if error == nil {
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.showErrorWithStatus(error!.localizedDescription)
            }
        }
    }

}
