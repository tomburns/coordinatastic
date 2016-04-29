//
//  CreateWidgetViewController.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

class CreateWidgetViewController: UIViewController {

    weak var coordinator: CreateWidgetFlowCoordinatorType?

    @IBAction func openURL(sender: AnyObject) {
        let destinationURL = AppDestination.WidgetDetail(id: 1).navigationURL(animated: false)

        UIApplication.sharedApplication().openURL(destinationURL)
    }

    @IBAction func openAnimatedURL(sender: AnyObject) {
        let destinationURL = AppDestination.WidgetDetail(id: 1).navigationURL()

        UIApplication.sharedApplication().openURL(destinationURL)
    }
    @IBAction func openSprocketURL(sender: AnyObject) {
        let destinationURL = AppDestination.Sprocket.navigationURL()

        UIApplication.sharedApplication().openURL(destinationURL)
    }
    @IBAction func cancel(sender: AnyObject) {
        coordinator?.cancel(animated: true)
    }
}
