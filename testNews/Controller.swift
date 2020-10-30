//
//  File.swift
//  testNews
//
//  Created by Malygin Georgii on 28.10.2020.
//

import Foundation

protocol ControllerInterface {
    func getItem()
    var itemsView: [JSONFile]? { get set }
}

class Controller: ControllerInterface {
    let viewController: ViewController
    let model: Model
    let dispatchQueue = DispatchQueue(label: "Zagruzka",qos: .userInteractive)
    let dispatchGroup = DispatchGroup()
    let dispatchSemaphore = DispatchSemaphore(value: 0)
    var page: Int = 1
    var itemsView: [JSONFile]? = [JSONFile]()
    
    func getItem() {
        dispatchQueue.async {
            for _ in 1...10 {
                self.dispatchGroup.enter()
                self.model.getItems(numberPage: String(self.page),success: { [weak self] data in
                    self?.page += 1
                    guard let sdata = data else {
                        self?.dispatchSemaphore.signal()
                        self?.dispatchGroup.leave()
                        return
                    }
                    
                    self?.itemsView?.append(sdata)
                    self?.dispatchSemaphore.signal()
                    self?.dispatchGroup.leave()
                }, failure: { [weak self] error in
                    print("Ya tut")
                    self?.viewController.showAlert()
                    self?.dispatchSemaphore.signal()
                    self?.dispatchGroup.leave()
                })
                
                self.dispatchSemaphore.wait()
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            DispatchQueue.main.async {
                self.viewController.updateCollectionView()
            }
        }
    }
    
    required init(viewController: ViewController, model: Model){
        self.viewController = viewController
        self.model = model
    }
}
