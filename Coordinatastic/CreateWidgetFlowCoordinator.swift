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
}

final class CreateWidgetFlowCoordinator: CreateWidgetFlowCoordinatorType {

    weak var presentationContext: UIViewController?

    private var widgetController: WidgetControllerType

    required init(presentationContext: UIViewController, widgetController: WidgetControllerType) {
        self.presentationContext = presentationContext

        self.widgetController = widgetController
    }

    func start() {
        guard let navController = R.storyboard.createWidget.navigationController(),
            let initialViewController = R.storyboard.createWidget.rootCreationViewController() else {
            preconditionFailure()
        }

        navController.viewControllers = [initialViewController]

        presentationContext?.presentViewController(navController, animated: true, completion: nil)
    }
}