//
//  Session.swift
//  FutureCombine
//
//  Created by Ahmed Fathy on 14/01/2023.
//

import Foundation
import Alamofire
import Combine

class Session {
    static let instance  = Session()
    private init() {}
    
    func requestCompletion<T: Codable>(to urlString: String, modelType: T.Type, complition: @escaping (Result<T, AFError>) -> Void){
        let url = URL(string: urlString)!
        AF.request(url).responseDecodable(of: modelType.self) { response in
            let result = response.result
            complition(result)
        }
    }
    
    func requestPulisher<T: Codable>(to urlString: String, modelType: T.Type) -> Future< T, AFError> {
        return Future { promise in
            let url = URL(string: urlString)!
            AF.request(url).responseDecodable(of: modelType.self) { response in
                let result = response.result
                promise(result)
            }
        }
    }
}
