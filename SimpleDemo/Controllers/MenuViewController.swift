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
    
    @IBOutlet weak var tokenTextField: HoshiTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hi!"
        
        let logoutBarButton: UIBarButtonItem = UIBarButtonItem.init(title: "Log out", style: .Done, target: self, action: Selector("logOutActionHandler"))
        self.navigationItem.rightBarButtonItem = logoutBarButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Show the token
        if let token = Stormpath.accessToken {
            self.tokenTextField.text = "..." + token.substringFromIndex(token.endIndex.advancedBy(-10))
        }
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
    
    @IBAction func refreshTokenActionHandler() {
        SVProgressHUD.show()
        
        Stormpath.refreshAccesToken { (newAccessToken, error) -> Void in
            if error == nil {
                SVProgressHUD.showSuccessWithStatus("Done!")
                if let token = newAccessToken {
                    self.tokenTextField.text = "..." + token.substringFromIndex(token.endIndex.advancedBy(-10))
                }
            } else {
                SVProgressHUD.showErrorWithStatus(error!.localizedDescription)
            }
        }
    }

}
