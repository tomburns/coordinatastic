//
//  WidgetDetailViewController.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import UIKit

class WidgetDetailViewController: UIViewController {

    weak var coordinator: WidgetsFlowCoordinatorType?

    var viewModel: WidgetDetailViewModel?

    @IBOutlet weak var nameLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let viewModel = viewModel {
            nameLabel.text = viewModel.name
        }
    }
    @IBAction func switchTo1(sender: AnyObject) {
        coordinator?.showDetail(id: 1, animated: true)
    }
    @IBAction func switchTo2(sender: AnyObject) {
        coordinator?.showDetail(id: 2, animated: true)
    }
    @IBAction func switchTo3(sender: AnyObject) {
        coordinator?.showDetail(id: 3, animated: true)
    }

    @IBAction func switchTo1Immediate(sender: AnyObject) {
        coordinator?.showDetail(id: 1, animated: false)
    }
    @IBAction func switchTo2Immediate(sender: AnyObject) {
        coordinator?.showDetail(id: 2, animated: false)
    }
    @IBAction func switchTo3Immediate(sender: AnyObject) {
        coordinator?.showDetail(id: 3, animated: false)
    }
}
