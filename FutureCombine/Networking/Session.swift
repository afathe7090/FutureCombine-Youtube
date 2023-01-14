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
    
    // request Completion
    func requestCompletion< T: Codable> (to urlString: String , modelType: T.Type, completion: @escaping (Result< T, AFError>)-> Void){
        let url = URL(string: urlString)!
        AF.request(url).responseDecodable(of: T.self) { response in
            let result = response.result
            completion(result)
        }
    }
    // request Future
    func requestPublisher< T: Codable> (to urlString: String , modelType: T.Type) -> Future< T, AFError>{
        return Future { promise in
            let url = URL(string: urlString)!
            AF.request(url).responseDecodable(of: T.self) { response in
                let result = response.result
                promise(result)
            }
        }
    }
    
}
