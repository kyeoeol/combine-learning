//
//  NetworkService.swift
//  CombineNetworkingWithTableView
//
//  Created by kyeoeol on 2022/07/24.
//

import Foundation
import Combine

enum NetworkServiceError: Error {
    case invalidURL
}

protocol NetworkServiceFetchable {
    func getPosts() -> AnyPublisher<[Post], Error>
}

class NetworkService: NetworkServiceFetchable {
    
    func getPosts() -> AnyPublisher<[Post], Error> {
        // get url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: NetworkServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        // return publisher
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
