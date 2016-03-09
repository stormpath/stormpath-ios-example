//
//  ProfileViewController.swift
//  Stormpath iOS Example
//
//  Created by Edward Jiang on 2/18/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class ProfileViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var modifiedAtLabel: UILabel!
    @IBOutlet weak var customDataTextView: UITextView!
    @IBOutlet weak var hrefTextField: UITextField!
    @IBOutlet weak var accessTokenTextField: UITextField!
    @IBOutlet weak var refreshTokenTextField: UITextField!
    
    var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        helloLabel.text = "Hello, \(account.fullName)!"
        emailLabel.text = "Email: \(account.email)"
        usernameLabel.text = "Username: \(account.username)"
        createdAtLabel.text = "Created At: \(account.createdAt)"
        modifiedAtLabel.text = "Updated At: \(account.modifiedAt)"
        customDataTextView.text = "Custom Data: " + (account.customData ?? "nil")
        hrefTextField.text = account.href.description
        accessTokenTextField.text = Stormpath.sharedSession.accessToken
        refreshTokenTextField.text = Stormpath.sharedSession.refreshToken
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshAccessToken(sender: AnyObject) {
        Stormpath.sharedSession.refreshAccessToken { (success, error) -> Void in
            self.viewWillAppear(false)
        }
    }

    @IBAction func logout(sender: AnyObject) {
        Stormpath.sharedSession.logout()
        dismissViewControllerAnimated(false, completion: nil)
    }
}
