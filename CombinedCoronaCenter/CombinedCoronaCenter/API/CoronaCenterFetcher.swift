//
//  CoronaCenterFetcher.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI
import Combine

protocol CoronaCenterFetchable {
    func coronaCenter() -> AnyPublisher<CoronaCenterResponse, CoronaError>
}

// MARK: - FETCHER

class CoronaCenterFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - FETCHABLE

extension CoronaCenterFetcher: CoronaCenterFetchable {
    func coronaCenter() -> AnyPublisher<CoronaCenterResponse, CoronaError> {
        return center(with: makeCoronaCenterComponents())
    }
    
    private func center<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, CoronaError> where T: Decodable {
        guard let url = components.url else {
            let error = CoronaError.network(description: "failed to get url.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: makeCoronaRequest(with: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { data, response in
                decode(data)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - API

private extension CoronaCenterFetcher {
    struct CoronaCenterAPI {
        static let scheme = "https"
        static let host = "api.odcloud.kr"
        static let path = "/api/15077603/v1/uddi:90bfb316-0caf-495b-92c0-c5cbc7bca1d9"
        static let key = coronaAPIKey
    }
    
    func makeCoronaCenterComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = CoronaCenterAPI.scheme
        components.host = CoronaCenterAPI.host
        components.path = CoronaCenterAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "perPage", value: "10")
        ]
        
        return components
    }
    
    func makeCoronaRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(CoronaCenterAPI.key, forHTTPHeaderField: "Authorization")
        return request
    }
}
