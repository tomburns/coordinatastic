//
//  FirstViewController.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

class WidgetListViewController: UIViewController {

    @IBOutlet weak var showFirstButton: UIButton!
    @IBOutlet weak var showSecondButton: UIButton!
    @IBOutlet weak var showThirdButton: UIButton!

    weak var coordinator: WidgetsFlowCoordinatorType?

    @IBAction func createWidget(sender: AnyObject) {
        coordinator?.showCreateWidget()
    }

    @IBAction func showFirst(sender: AnyObject) {
        coordinator?.showDetail(id: 1, animated: true)
    }

    @IBAction func showSecond(sender: AnyObject) {
        coordinator?.showDetail(id: 2, animated: true)
    }

    @IBAction func showThird(sender: AnyObject) {
        coordinator?.showDetail(id: 3, animated: true)
    }
}

