//
//  AppDelegate.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appCoordinator: AppCoordinatorType?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let window = UIWindow()
        self.window = window

        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator

        appCoordinator.start()

        window.makeKeyAndVisible()

        return true
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return appCoordinator?.openURL(url) ?? false
    }
}

