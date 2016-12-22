# Stormpath iOS Example App

This is the example app for the [Stormpath iOS SDK](https://github.com/stormpath/stormpath-sdk-ios).

# Usage

## Running the iOS Example

To get started, first download this repository by cloning it from GitHub: 

```git
git clone https://github.com/stormpath/stormpath-ios-example.git
```

Open up `Stormpath iOS Example.xcworkspace` and run the app. The app has two targets: Stormpath ObjC Example, and Stormpath Swift Example. You can run each example individually and look at the code to see how they work. 

The sample app is currently configured to run against `https://stormpath-notes.apps.stormpath.io/` (an application we have running), but you can change this by adding a line of code in the AppDelegate:

```Swift
Stormpath.sharedSession.configuration.APIURL = URL(string: "https://[MYAPP].apps.stormpath.io/")!
```

```Objective-C
[[SPHStormpath sharedSession] configuration].APIURL = [[NSURL alloc] initWithString:@"https://[MYAPP].apps.stormpath.io"];
```

## Social Login

The sample app is configured with the Facebook and Google logins for our demo server, but to use this with your own server, you'll need to set up social login with the instructions in the [Client API Guide](https://docs.stormpath.com/client-api/product-guide/latest/social_login.html#before-you-start). Once you map Facebook & Google directories to your own application, you're good to go! 

## Comments

Let us know what you think! Please email us @ support@stormpath.com, or open an issue on this GitHub.

# License

This project is open-source via [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0). See the LICENSE file for details.