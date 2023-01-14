//
//  ViewController.swift
//  FutureCombine
//
//  Created by Ahmed Fathy on 14/01/2023.
//

import UIKit
import Combine
import Alamofire

class ViewController: UIViewController {
    
    let url = "https://jsonplaceholder.typicode.com/users"
    var anyCancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestCompletion()
//        requestPublsiher()
        
        requestPublsiher(filterByName: "Ervin Howell")
            .sink { users in
                print(users)
            }.store(in: &anyCancelable)
    }
    func requestCompletion(){
        Session.instance.requestCompletion(to: url, modelType: [User].self) { result in
            switch result {
            case .success(let users):
                print(users)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestPublsiher(filterByName: String) -> AnyPublisher< [User] , Never>  {
        return Session.instance.requestPublisher(to: url, modelType: [User].self)
            .map({$0.filter({$0.name == filterByName})})
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}

