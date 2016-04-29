//
//  FlowCoordinatorType.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

protocol FlowCoordinatorType: class {
    var rootViewController: UIViewController { get }

    func start()

    func dismissPresentedViewController(animated animated: Bool)
}

extension FlowCoordinatorType {
    func dismissPresentedViewController(animated animated: Bool) {
        rootViewController.presentedViewController?.dismissViewControllerAnimated(animated, completion: nil)
    }
}