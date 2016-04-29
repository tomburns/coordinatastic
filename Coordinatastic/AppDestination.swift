//
//  AppDestination.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import Foundation

enum AppDestination {
    case WidgetList
    case WidgetDetail(id: Int)
    case CreateWidget
    case Sprocket

    func navigationURL(animated animated: Bool = true) -> NSURL {
        let components = NSURLComponents()

        components.scheme = "coord"
        components.queryItems = []

        switch self {
        case .WidgetList:
            components.host = "widget"
        case WidgetDetail(let widgetID):
            components.host = "widget"
            components.path = "/\(widgetID)"
        case CreateWidget:
            components.host = "widget"
            components.path = "/create"
        case Sprocket:
            components.host = "sprocket"
        }

        if animated {
            components.queryItems?.append(NSURLQueryItem(name: "animated", value: nil))
        }

        return components.URL!
    }
}