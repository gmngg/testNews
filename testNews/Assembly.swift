//
//  Assembly.swift
//  testNews
//
//  Created by Malygin Georgii on 29.10.2020.
//

import UIKit

class Assembly {
    static func start() -> UIViewController {
        let vc = ViewController()
        let model = Model()
        let controller = Controller(viewController: vc, model: model)
        vc.controller = controller
        return vc
    }
}
