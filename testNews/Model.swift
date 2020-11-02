//
//  Model.swift
//  testNews
//
//  Created by Malygin Georgii on 28.10.2020.
//

import Foundation

protocol ModelInterface {
    func getItems(numberPage: String, success:((JSONFile?) -> Void)?, failure: ((Error) -> Void)?)
}

class Model: ModelInterface {
    let network = NetworkServise()
    
    func getItems(numberPage: String, success:((JSONFile?) -> Void)?, failure: ((Error) -> Void)?) {
        network.getItems(numberList: numberPage, comletion: { response in
            switch response {
            case .success(let data):
                success?(data)
            case .failure(let error):
                print()
                failure?(error)
            }
        })
    }
}

