//
//  RegistrationAPIRequestManager.swift
//  Stormpath
//
//  Created by Edward Jiang on 2/5/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import Foundation

class RegistrationAPIRequestManager: APIRequestManager {
    var account: RegistrationModel
    var callback: StormpathAccountCallback
    
    init(withURL url: NSURL, newAccount account: RegistrationModel, callback: StormpathAccountCallback) {
        self.account = account
        self.callback = callback
        super.init(withURL: url)
    }
    
    override func prepareForRequest() {
        var registrationDictionary: [String: AnyObject] = account.customFields
        let accountDictionary = ["username": account.username, "email": account.email, "password": account.password, "givenName": account.givenName, "surname": account.surname]
        
        for (key, value) in accountDictionary {
            registrationDictionary[key] = value
        }
        
        request.HTTPMethod = "POST"
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(registrationDictionary, options: [])
    }
    
    override func requestDidFinish(data: NSData, response: NSHTTPURLResponse) {
        if let user = Account(fromJSON: data) {
            executeCallback(user, error: nil)
        } else {
            executeCallback(nil, error: StormpathError.APIResponseError) 
        }
    }
    
    override func executeCallback(parameters: AnyObject?, error: NSError?) {
        dispatch_async(dispatch_get_main_queue()) { 
            self.callback(parameters as? Account, error)
        }
    }
}

/**
 Model for the account registration form. The fields requested in the initializer 
 are required.
 */
public class RegistrationModel: NSObject {
    
    /**
     Given (first) name of the user. Required by default, but can be turned off 
     in the Framework configuration.
     */
    public var givenName = ""
    
    /**
     Sur (last) name of the user. Required by default, but can be turned off in 
     the Framework configuration.
     */
    public var surname = ""
    
    /// Email address of the user. Only validated server-side at the moment.
    public var email: String
    
    /// Password for the user. Only validated server-side at the moment.
    public var password: String
    
    /**
     Username. Optional, but if not set retains the value of the email address.
     */
    public var username = ""
    
    /**
     Custom fields may be configured in the server-side API. Include them in 
     this
     */
    public var customFields = [String: String]()
    
    /**
     Initializer for Registration Model. After initialization, all fields can be 
     modified. 
     
     - parameters:
       - givenName: Given (first) name of the user.
       - surname: Sur (last) name of the user.
       - email: Email address of the user.
       - password: Password for the user.
     */
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}