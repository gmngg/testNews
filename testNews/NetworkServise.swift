//
//  NetworkServise.swift
//  testNews
//
//  Created by Malygin Georgii on 28.10.2020.
//

import Foundation

class NetworkServise {
    
    let requestNetwork = RequestNetwork()
    
    func getItems(numberList: String, comletion: @escaping (Result<JSONFile?, Error>) -> Void) {
        self.fetchJSON(numberList: numberList, response: comletion)
    }
    
    private func fetchJSON<T : Decodable>(numberList: String, response: @escaping(Result<T?, Error>) -> Void) {
        requestNetwork.request(numberList: numberList) { (result) in
            switch result {
            case .success(let data):
                let decodedData = self.decodeJSON(type: T.self, from: data)
                response(.success(decodedData))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}
