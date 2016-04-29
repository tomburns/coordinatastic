//
//  SprocketsFlowCoordinator.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

protocol SprocketsFlowCoordinatorType: FlowCoordinatorType {
    init(navigationController: UINavigationController)
}

final class SprocketsFlowCoordinator: SprocketsFlowCoordinatorType {

    var rootViewController: UIViewController {
        return navigationController
    }

    private let navigationController: UINavigationController

    private let storyboard = R.storyboard.sprockets()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            preconditionFailure("Failed to instantiate initial view controller")
        }

        navigationController.viewControllers = [initialViewController]
    }
}