//
//  WidgetDetailViewModel.swift
//  Coordinatastic
//
//  Created by Tom Burns on 4/29/16.
//  Copyright © 2016 Sittercity. All rights reserved.
//

import Foundation

protocol WidgetDetailViewModelType {
    init(widget: Widget)

    var name: String { get }
}

class WidgetDetailViewModel: WidgetDetailViewModelType {
    let name: String

    required init(widget: Widget) {
        self.name = widget.name
    }
}