//
//  WidgetController.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import Foundation

protocol WidgetControllerType {
    func fetchWidget(id id: Int) -> Widget?
}

class WidgetController: WidgetControllerType{

    private let widget1 = Widget(id: 1, name: "First Widget")
    private let widget2 = Widget(id: 2, name: "Next Widget")
    private let widget3 = Widget(id: 3, name: "Last Widget")

    private lazy var widgets: [Widget] = {
        return [self.widget1, self.widget2, self.widget3]
        }()

    func fetchWidget(id id: Int) -> Widget? {
        return widgets
            .filter {
                return $0.id == id
            }
            .first
    }
}