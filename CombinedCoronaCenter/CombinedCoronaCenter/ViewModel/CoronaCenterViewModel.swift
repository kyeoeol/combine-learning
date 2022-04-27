//
//  CoronaCenterViewModel.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI
import Combine

class CoronaCenterViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private let coronaCenterFetcher: CoronaCenterFetchable
    
    @Published var coronaCenters = [CoronaCenter]()
    
    init(
        coronaCenterFetcher: CoronaCenterFetchable = CoronaCenterFetcher()
    ) {
        self.coronaCenterFetcher = coronaCenterFetcher
    }
    
    func fetchCoronaCenter() {
        coronaCenterFetcher.coronaCenter()
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.coronaCenters = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] centers in
                self?.coronaCenters = centers
            }
            .store(in: &cancellable)
    }
}
