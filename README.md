# Stormpath iOS Example App

This is the example app for the [Stormpath iOS SDK](https://github.com/stormpath/stormpath-sdk-swift).

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

## Comments

Let us know what you think! Please email us @ support@stormpath.com, or open an issue on this GitHub.

# License

This project is open-source via [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0). See the LICENSE file for details.