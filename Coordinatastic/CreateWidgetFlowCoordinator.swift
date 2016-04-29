//
//  CreateWidgetFlowCoordinator.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

protocol CreateWidgetFlowCoordinatorType: FlowCoordinatorType {
    init(presentationContext: UIViewController, widgetController: WidgetControllerType)
    func cancel(animated animated: Bool)
}

final class CreateWidgetFlowCoordinator: CreateWidgetFlowCoordinatorType {

    var rootViewController: UIViewController {
        return navigationController
    }

    private weak var presentationContext: UIViewController?

    private var navigationController = UINavigationController()

    private var widgetController: WidgetControllerType

    required init(presentationContext: UIViewController, widgetController: WidgetControllerType) {
        self.presentationContext = presentationContext

        self.widgetController = widgetController
    }

    func start() {
        guard let initialViewController = R.storyboard.createWidget.rootCreationViewController() else {
            preconditionFailure()
        }

        let navigationController = UINavigationController(rootViewController: initialViewController)

        self.navigationController = navigationController
        initialViewController.coordinator = self

        presentationContext?.presentViewController(navigationController, animated: true, completion: nil)
    }

    func cancel(animated animated: Bool) {
        navigationController.dismissViewControllerAnimated(animated, completion: nil)
    }
}