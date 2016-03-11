# Stormpath iOS Example App

This is the example app for the [Stormpath iOS SDK](https://github.com/stormpath/stormpath-sdk-ios).

# Usage

## Set up an API Server

The Stormpath iOS Example App requires a Stormpath framework integration to be installed and running as an API.

The easiest way to do this is to set up the [express sample project](https://github.com/stormpath/express-stormpath-sample-project).

## Running the iOS Example

To get started, first download this repository by cloning it from GitHub: 

```git
git clone https://github.com/stormpath/stormpath-ios-example.git
```

Open up `Stormpath iOS Example.xcworkspace` and run the app. The app has two targets: Stormpath ObjC Example, and Stormpath Swift Example. You can run each example individually and look at the code to see how they work. 

The sample app is currently configured to run against `http://localhost:3000/` (the default for the express sample project), but you can change this by adding a line of code in the AppDelegate:

```Swift
StormpathConfiguration.defaultConfiguration.APIURL = NSURL(string: "http://localhost:3000")!
```

```Objective-C
[StormpathConfiguration defaultConfiguration].APIURL = [[NSURL alloc] initWithString:@"http://localhost:3000"];
```

## Social Login

To use Log in with Facebook / Google in this app, you'll need to take a few additional steps:

### Setting up Facebook Login

To get started, you first need to [register an application](https://developers.facebook.com/?advanced_app_create=true) with Facebook. After registering your app, go into your app dashboard's settings page. Click "Add Platform", and fill in your Bundle ID, and turn "Single Sign On" on. 

Then, [sign into Stormpath](https://api.stormpath.com/login) and add a Facebook directory to your account. Fill the App ID and Secret with the values given to you in the Facebook app dashboard. Then, add the directory to your Stormpath application. 

Finally, open up your App's Xcode project and go to the project's info tab. Under "URL Types", add a new entry, and in the URL schemes form field, type in `fb[APP_ID_HERE]`, replacing `[APP_ID_HERE]` with your Facebook App ID. 

### Setting up Google Login

To get started, you first need to [register an application](https://console.developers.google.com/project) with Google. Click "Enable and Manage APIs", and then the credentials tab. Create two sets of OAuth Client IDs, one as "Web Application", and one as "iOS". 

Then, [sign into Stormpath](https://api.stormpath.com/login) and add a Google directory to your account. Fill in the Client ID and Secret with the values given to you for the web client. (You can fill in "Google Authorized Redirect URI" with `http://YOURSERVER/callbacks/google`. Then, add the directory to your Stormpath application. 

Finally, open up your App's Xcode project and go to the project's info tab. Under "URL Types", add a new entry, and in the URL schemes form field, type in your Google iOS Client's `iOS URL scheme` from the Google Developer Console. 

## Comments

Let us know what you think! Please email us @ support@stormpath.com, or open an issue on this GitHub.

# License

This project is open-source via [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0). See the LICENSE file for details.