//
//  Stormpath.swift
//  Stormpath
//
//  Created by Adis on 16/11/15.
//  Copyright © 2015 Stormpath. All rights reserved.
//

import UIKit

public typealias CompletionBlockWithDictionary = ((NSDictionary?, NSError?) -> Void)
public typealias CompletionBlockWithString     = ((String?, NSError?) -> Void)
public typealias CompletionBlockWithError      = ((NSError?) -> Void)

public final class Stormpath: NSObject {
    
    // API vars
    
    internal class var APIURL: String? {
        get {
            return KeychainService.APIURL
        }
        
        set {
            KeychainService.APIURL = newValue
        }
    }
    
    // MARK: Initial setup
    
    /**
    Use this method for the initial setup for your Stormpath backend.
    
    - parameter APIURL: The base URL of your API, eg. "https://api.stormpath.com". The trailing slash is unnecessary.
    */
    public class func setUpWithURL(APIURL: String) {
        // TODO: Add guards
        
        // Trim the trailing slash if needed
        if APIURL.hasSuffix("/") {
            self.APIURL = String(APIURL.characters.dropLast())
        } else {
            self.APIURL = APIURL
        }
    }
    
    // MARK: User registration
    
    /**
     This method registers a user from the data provided.
     
     - parameter customPath: Relative path for your register. Can be omitted.
     - parameter userDictionary: User data in the form of a dictionary. Check the docs for more info: http://docs.stormpath.com/rest/product-guide/#create-an-account
     - parameter completionHandler: The completion block to be invoked after the API request is finished. It returns a dictionary with user data,
        or an error if one occured.
     */
    
    public class func register(customPath: String? = nil, userDictionary: Dictionary<String, String>, completionHandler: CompletionBlockWithDictionary) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.register(customPath, userDictionary: userDictionary, completionHandler: completionHandler)
        
    }
    
    // MARK: User login
    
    /**
    Logs in a user and assumes that the login path is behind the /login relative path. This method also stores the user session tokens for later use.
    
    - parameter customPath: Relative path for your login. Pass nil or ommit if you didn't change custom routes.
    - parameter username: User username.
    - parameter password: User password.
    - parameter completionHandler: The completion block to be invoked after the API request is finished. If the method fails, the error will be passed in the completion.
    */
    
    public class func login(customPath: String? = nil, username: String, password: String, completionHandler: CompletionBlockWithString) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.login(customPath, username: username, password: password, completionHandler: completionHandler)
        
    }
    
    /**
     Fetches the user data, and returns it in the form of a dictionary.
     
     - parameter customPath: Optional parameter, use it if you remapped the /me path to something else.
     - parameter completionHandler: Completion block invoked
     */
    
    public class func me(customPath: String? = nil, completionHandler: CompletionBlockWithDictionary) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.me(customPath, completionHandler: completionHandler)
        
    }
    
    // MARK: User logout
    
    /**
    Logs out the user and clears the sessions tokens.
    
    - parameter customPath: Relative path for logout. Omit if not used.
    - parameter completionHandler: The completion block to be invoked after the API request is finished. If the method fails, the error will be passed in the completion.
    */

    
    public class func logout(customPath: String? = nil, completionHandler: CompletionBlockWithError) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.logout(customPath, completionHandler: completionHandler)
        
    }
    
    // MARK: User password reset
    
    /**
    Generates a user password reset token and sends an email to the user, if such email exists.
    
    - parameter customPath: Custom path to your forgot password. Omit if not changed from default.
    - parameter email: User email. Usually from an input.
    - parameter completionHandler: The completion block to be invoked after the API request is finished. If there were errors, they will be passed in the completion block.
    */
    
    public class func resetPassword(customPath: String? = nil, email: String, completionHandler: CompletionBlockWithError) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.resetPassword(customPath, email: email, completionHandler: completionHandler)
        
    }
    
    // MARK: Token management
    
    /**
    Provides the last access token fetched by either login or refreshAccessToken functions. The validity of the token is not verified upon fetching!
    
    - returns: Access token for your API calls.
    */
    
    public class var accessToken: String? {
        
        get {
            return KeychainService.accessToken
        }
        
    }
    
    /**
     Refreshes the access token and stores it to be available via accessToken var. Call this function if your token expires.
     
     - parameter customPath: Relative path to your *login* call, omit if login was not changed in the config.
     - parameter completionHandler: Block invoked on function completion. It will have either a new access token passed as a string, or an error if one occured.
     */
    
    public class func refreshAccesToken(customPath: String? = nil, completionHandler: CompletionBlockWithString) {
        
        assert(self.APIURL != nil, "Please set up the API URL with Stormpath.setUpWithURL() function")
        APIService.refreshAccessToken(customPath, completionHandler: completionHandler)
        
    }
    
    /**
     Sets the log level to enable console output of network requests to your API.
     
     - parameter level: Level of logging, defaults to None.
        * .None - no output.
        * .Debug - will display which API calls are being used and their responses.
        * .Verbose - same as .Debug, but will output the headers and bodies of requests.
        * .Error - will output errors only.
     */
     
    public class func setLogLevel(level: LogLevel) {
        
        Logger.logLevel = level
        
    }
    
}
