//
//  StormpathConfig.swift
//  Stormpath
//
//  Created by Edward Jiang on 1/29/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import Foundation

/**
 StormpathConfiguration is the class that manages the configuration for 
 Stormpath, its endpoints, and API providers. It auto-loads from the
 configuration in Info.plist, or uses defaults that connect to a server on
 http://localhost:3000, the default in many Stormpath integrations. You can
 modify its properties directly.
 
 - note: The endpoints refer to the endpoints in the Stormpath Framework Spec. 
   Use leading slashes to specify the endpoints.
 */
public class StormpathConfiguration: NSObject {
    /**
     Singleton object representing the default configuration loaded from the 
     config file. Used by the main Stormpath instance. Can be modified 
     programmatically.
     */
    public static var defaultConfiguration = StormpathConfiguration()
    
    /// Configuration parameter for the API URL.
    public var APIURL = NSURL(string: "http://localhost:3000")! {
        didSet {
            APIURL = APIURL.absoluteString.withoutTrailingSlash.asURL ?? APIURL
        }
    }
    
    /// Endpoint for the current user context
    public var meEndpoint = "/me" {
        didSet {
            meEndpoint = meEndpoint.withLeadingSlash
        }
    }
    
    /// Endpoint to request email verification
    public var verifyEmailEndpoint = "/verify" {
        didSet {
            verifyEmailEndpoint = verifyEmailEndpoint.withLeadingSlash
        }
    }
    
    /// Endpoint to request a password reset email
    public var forgotPasswordEndpoint = "/forgot" {
        didSet {
            forgotPasswordEndpoint = forgotPasswordEndpoint.withLeadingSlash
        }
    }
    
    /// Endpoint to create an OAuth token
    public var oauthEndpoint = "/oauth/token" {
        didSet {
            oauthEndpoint = oauthEndpoint.withLeadingSlash
        }
    }
    
    /**
     Endpoint to logout
     */
    public var logoutEndpoint = "/logout" {
        didSet {
            logoutEndpoint = logoutEndpoint.withLeadingSlash
        }
    }
    
    /// Endpoint to register a new account
    public var registerEndpoint = "/register" {
        didSet {
            registerEndpoint = registerEndpoint.withLeadingSlash
        }
    }
    
    /**
     Initializer for StormpathConfiguration. The initializer pulls defaults from 
     the Info.plist file, and falls back to default SDK values. Modify the 
     values after initialization to customize this object. 
     */
    public override init() {
        super.init()
        guard let stormpathInfo = NSBundle.mainBundle().infoDictionary?["Stormpath"] as? [String: AnyObject] else {
            return
        }
        
        APIURL = (stormpathInfo["APIURL"] as? String)?.asURL ?? APIURL
        
        guard let customEndpoints = stormpathInfo["customEndpoints"] as? [String: AnyObject] else {
            return
        }
        
        meEndpoint = (customEndpoints["me"] as? String) ?? meEndpoint
        verifyEmailEndpoint = (customEndpoints["verifyEmail"] as? String) ?? verifyEmailEndpoint
        forgotPasswordEndpoint = (customEndpoints["forgotPassword"] as? String) ?? forgotPasswordEndpoint
        oauthEndpoint = (customEndpoints["oauth"] as? String) ?? oauthEndpoint
        logoutEndpoint = (customEndpoints["logout"] as? String) ?? logoutEndpoint
        registerEndpoint = (customEndpoints["register"] as? String) ?? registerEndpoint
    }
}

/// Helper extensions to make the initializer easier.
private extension String {
    var withLeadingSlash: String {
        if hasPrefix("/") {
            return self
        } else {
            return "/" + self
        }
    }
    
    var withoutTrailingSlash: String {
        if hasSuffix("/") {
            return substringToIndex(endIndex.advancedBy(-1))
        } else {
            return self
        }
    }
    
    var asURL: NSURL? {
        return NSURL(string: self)
    }
}