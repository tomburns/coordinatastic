//
//  AppCoordinator.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

protocol AppCoordinatorType {
    init(window: UIWindow)

    func openURL(url: NSURL) -> Bool
}

class AppCoordinator: AppCoordinatorType, FlowCoordinatorType {

    var rootViewController: UIViewController {
        return tabBarController
    }

    private let widgetCoordinator: WidgetsFlowCoordinatorType
    private let sprocketCoordinator: SprocketsFlowCoordinatorType

    private weak var window: UIWindow?

    private let storyboard = R.storyboard.main()

    private let tabBarController: UITabBarController

    required init(window: UIWindow) {
        self.window = window

        guard let tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController else {
            preconditionFailure("Failed to instantiate root tab bar controller")
        }

        guard let firstNavController = tabBarController.viewControllers?[0] as? UINavigationController,
            let secondNavController = tabBarController.viewControllers?[1] as? UINavigationController else {
            preconditionFailure("Didn't find widget nav controller in expected location.")
        }

        widgetCoordinator = WidgetsFlowCoordinator(navigationController: firstNavController)
        sprocketCoordinator = SprocketsFlowCoordinator(navigationController: secondNavController)

        self.tabBarController = tabBarController
        window.rootViewController = rootViewController
    }

    func start() {
        widgetCoordinator.start()
        sprocketCoordinator.start()
    }

    func openURL(url: NSURL) -> Bool {

        guard let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false) else {
            return false
        }

        switch urlComponents.host {
        case .Some("widget"):
            let animated = urlComponentsContainAnimationFlag(urlComponents)

            tabBarController.selectedIndex = 0

            if let pathComponents = url.pathComponents,
                let widgetIDString = pathComponents.last,
                let widgetID = Int(widgetIDString) {
                widgetCoordinator.showDetail(id: widgetID, animated: animated)
            }

            return true
        default:
            return false
        }
    }

    private func urlComponentsContainAnimationFlag(urlComponents: NSURLComponents) -> Bool {
        guard let queryItems = urlComponents.queryItems else {
            return false
        }

        let filteredKeys = queryItems.filter { $0.name == "animated" }

        return filteredKeys.count > 0
    }
}