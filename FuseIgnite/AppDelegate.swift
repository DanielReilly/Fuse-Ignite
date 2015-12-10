//
//  AppDelegate.swift
//  FuseIgnite
//
//  Created by Daniel Reilly on 22/09/2015.
//  Copyright © 2015 Fuse Technology. All rights reserved.
//


import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        func ParseAppID() {
        
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("d5LFK2as7ay0obVjQ2pMMRQkkMaBbPixMSJwo2dc",
            clientKey: "sTfq0xw8w0SoxNwZP0gn1ZWHL3f6anQORVV95BfU")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    }
    
        func NavigationDrawer() -> Bool {
            
            var centerContainer: MMDrawerController?
            
                // Override point for customization after application launch.
                _ = self.window!.rootViewController
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("EventFeedViewController") as! ViewController
                
                let leftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LeftSideViewController")as! LeftSideViewController
                
                
                let leftSideNav = UINavigationController(rootViewController: leftViewController)
                let centerNav = UINavigationController(rootViewController: centerViewController)
                
                centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav)
                
                centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView;
                centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView;
                
                window!.rootViewController = centerContainer
                window!.makeKeyAndVisible()
                
                return true
            }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

