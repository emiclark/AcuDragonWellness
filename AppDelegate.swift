//
//  AppDelegate.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/22/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit
//import Google

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let MY_CLIENT_ID = "844411766152-cjl9ofh6au9ntejf4fam6dhod4fnisg5.apps.googleusercontent.com"

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = UIViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        
        // remove black bar beneath navbar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(),for: .default)
        
        application.statusBarStyle = .lightContent

        // add darker red to status bar
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor.rgb(red: 194, green: 40, blue: 40)
        window?.addSubview(statusBarView)
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarView)
        window?.addConstraintsWithFormat(format: "V:|[v0(30)]", views: statusBarView)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//====================== below with google signIn ================
////
////  AppDelegate.swift
////  AcuDragon
////
////  Created by Emiko Clark on 1/22/18.
////  Copyright © 2018 Emiko Clark. All rights reserved.
////
//
//import UIKit
//import Google
//import GoogleSignIn
//
//@UIApplicationMain
////class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    let MY_CLIENT_ID = "844411766152-cjl9ofh6au9ntejf4fam6dhod4fnisg5.apps.googleusercontent.com"
//
//    //    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//    //              withError error: Error!) {
//    //        if let error = error {
//    //            print("\(error.localizedDescription)")
//    //        } else {
//    //            // Perform any operations on signed in user here.
//    //            let userId = user.userID                  // For client-side use only!
//    //            let idToken = user.authentication.idToken // Safe to send to the server
//    //            let fullName = user.profile.name
//    //            let givenName = user.profile.givenName
//    //            let familyName = user.profile.familyName
//    //            let email = user.profile.email
//    //            // ...
//    //        }
//    //    }
//
//    //    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//    //              withError error: Error!) {
//    //        // Perform any operations when the user disconnects from app here.
//    //        // ...
//    //    }
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        let vc = UIViewController()
//        let navigationController = UINavigationController(rootViewController: vc)
//        self.window?.rootViewController = navigationController
//        self.window!.makeKeyAndVisible()
//        let layout = UICollectionViewFlowLayout()
//        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
//
//        // remove black bar beneath navbar
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(),for: .default)
//
//        application.statusBarStyle = .lightContent
//
//        // add darker red to status bar
//        let statusBarView = UIView()
//        statusBarView.backgroundColor = UIColor.rgb(red: 194, green: 40, blue: 40)
//        window?.addSubview(statusBarView)
//        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarView)
//        window?.addConstraintsWithFormat(format: "V:|[v0(30)]", views: statusBarView)
//
//        //         Initialize sign-in
//        //        GIDSignIn.sharedInstance().clientID = "YOUR_CLIENT_ID"
//        //        GIDSignIn.sharedInstance().delegate = self
//
//        // Initialize sign-in
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
//
//        return true
//    }
//
//    //    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//    //        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
//    //        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
//    //        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
//    //    }
//
//    //    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//    //        return GIDSignIn.sharedInstance().handle(url,
//    //        sourceApplication: sourceApplication,
//    //        annotation: annotation)
//    //    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    }
//
//
//}
//

