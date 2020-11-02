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
    var itemsView: [JSONFile]? = [JSONFile]()

    var page: Int = 1
    
    func getItem() {
        dispatchQueue.async {
            self.model.getItems(numberPage: String(self.page),success: { [weak self] data in
                guard let sdata = data else {
                    return
                }
                switch self!.page {
                case 1:
                    self?.itemsView?.append(sdata)
                case 1...(self?.itemsView?.first?.meta?.last_page)!: self?.itemsView?[0].data.append(contentsOf: sdata.data)
                default:
                    self?.itemsView?.first?.meta?.per_page!
                    print("Дефолт")
            }
                self?.page += 1
                self?.viewController.updateCollectionView()
            }, failure: { [weak self] error in
                self?.viewController.showAlert()
            })
            
        }
    }
    
    required init(viewController: ViewController, model: Model){
        self.viewController = viewController
        self.model = model
    }
}
