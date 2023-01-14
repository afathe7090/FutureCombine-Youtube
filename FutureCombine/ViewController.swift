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
    
    @Published var users: [User] = []
    private var anyCancellable = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestCompletion()
//        requestPublisehr()
    
        $users.sink { users in
            print(users)
        }.store(in: &anyCancellable)
        
        returnFilteredRequestAsANyPublisher(filterByName: "Ervin Howell")
    }
    
    func requestCompletion(){
        Session.instance.requestCompletion(to: "https://jsonplaceholder.typicode.com/users", modelType: [User].self) { result in
            switch result {
            case .success(let users):
                print(users)
                // All Process
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestPublisehr(){
        Session.instance.requestPulisher(to: "https://jsonplaceholder.typicode.com/users", modelType: [User].self)
            .sink { finsihed in
                print(finsihed)
            } receiveValue: { users in
                print(users)
            }.store(in: &anyCancellable)
    }
    
    func returnFilteredRequestAsANyPublisher(filterByName: String) {
        Session.instance.requestPulisher(to: "https://jsonplaceholder.typicode.com/users", modelType: [User].self)
            .replaceError(with: [])
            .map({$0.filter({$0.name == filterByName})})
            .eraseToAnyPublisher()
            .assign(to: &$users)
    }
    
}

