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

    enum MainTab {
        case Widget
        case Sprocket

        var index: Int {
            switch self {
            case .Widget:
                return 0
            case .Sprocket:
                return 1
            }
        }
    }
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

    //MARK: URL Handling

    func openURL(url: NSURL) -> Bool {
        switch url.host {
        case .Some("widget"):
            handleWidgetURL(url)
            return true
        case .Some("sprocket"):
            handleSprocketURL(url)
            return true
        default:
            return false
        }
    }

    private func handleWidgetURL(url: NSURL) {
        precondition(url.host == "widget")

        let animated = urlContainsAnimationFlag(url)

        switchTabsIfNeeded(.Widget, animated: animated)

        if let pathComponents = url.pathComponents,
            let widgetPathString = pathComponents.last {

            if let id = Int(widgetPathString) {
                widgetCoordinator.showDetail(id: id, animated: animated)
            } else if widgetPathString == "create" {
                widgetCoordinator.showCreateWidget(animated: animated)
            }

        }

    }

    private func handleSprocketURL(url: NSURL) {
        precondition(url.host == "sprocket")

        let animated = urlContainsAnimationFlag(url)

        switchTabsIfNeeded(.Sprocket, animated: animated)

    }



    private func switchTabsIfNeeded(destinationTab: MainTab, animated: Bool) {
        if tabBarController.selectedIndex != destinationTab.index {
            dismissAllPresentedViewControllers(animated: animated)
            tabBarController.selectedIndex = destinationTab.index
        }
    }

    private func dismissAllPresentedViewControllers(animated animated: Bool) {
        self.dismissPresentedViewController(animated: animated)
        widgetCoordinator.dismissPresentedViewController(animated: animated)
        sprocketCoordinator.dismissPresentedViewController(animated: animated)
    }

    private func resetAllFlows(animated animated: Bool) {
        dismissAllPresentedViewControllers(animated: animated)

        widgetCoordinator.showList(animated: animated)

        // other logic would go here
    }

    private func urlContainsAnimationFlag(url: NSURL) -> Bool {
        guard let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
            return false
        }

        let filteredKeys = queryItems.filter { $0.name == "animated" }

        return filteredKeys.count > 0
    }
}