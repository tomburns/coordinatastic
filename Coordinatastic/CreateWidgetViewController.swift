//
//  CreateWidgetViewController.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

class CreateWidgetViewController: UIViewController {

    @IBAction func openURL(sender: AnyObject) {
        let destinationURL = NSURL(string: "coord://widget/1")!

        UIApplication.sharedApplication().openURL(destinationURL)
    }

    @IBAction func openAnimatedURL(sender: AnyObject) {
        let destinationURL = NSURL(string: "coord://widget/1?animated")!

        UIApplication.sharedApplication().openURL(destinationURL)
    }
}
