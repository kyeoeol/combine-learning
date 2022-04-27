//
//  Decode.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, CoronaError> {
    let decode = JSONDecoder()
    decode.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decode)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
