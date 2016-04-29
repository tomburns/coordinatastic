//
//  WidgetsFlowCoordinator.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit


protocol WidgetsFlowCoordinatorType: FlowCoordinatorType {
    init(navigationController: UINavigationController)

    func showDetail(id id: Int, animated: Bool)
    func showCreateWidget()
}

final class WidgetsFlowCoordinator: WidgetsFlowCoordinatorType {
    private let navigationController: UINavigationController

    private let widgetController = WidgetController()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let initialViewController = R.storyboard.widgets.widgetListViewController() else {
            preconditionFailure("Failed to instantiate initial view controller")
        }

        initialViewController.coordinator = self

        navigationController.viewControllers = [initialViewController]
    }

    func showDetail(id id: Int, animated: Bool) {
        guard let widget = widgetController.fetchWidget(id: id) else {
            // we could maybe throw here instead to give the caller the option to catch and react?
            return
        }

        prepareToShowDetail(animated: animated) { [navigationController] in
            let viewModel = WidgetDetailViewModel(widget: widget)

            guard let detailViewController = R.storyboard.widgets.widgetDetailViewController() else {
                preconditionFailure("Failed to instantiate widget detail view controller")
            }

            detailViewController.coordinator = self
            detailViewController.viewModel = viewModel

            navigationController.pushViewController(detailViewController, animated: animated)
        }
    }

    func showCreateWidget() {
        let creationCoordinator = CreateWidgetFlowCoordinator(presentationContext: navigationController, widgetController: widgetController)

        creationCoordinator.start()
    }

    private func prepareToShowDetail(animated animated: Bool, completion: (() -> ())?) {

        if navigationController.visibleViewController != navigationController.viewControllers[0] {
            navigationController.popToRootViewControllerAnimated(animated)
        }

        if navigationController.presentedViewController != nil {
            navigationController.presentedViewController?.dismissViewControllerAnimated(animated, completion: completion)
        } else {
            completion?()
        }


    }
}