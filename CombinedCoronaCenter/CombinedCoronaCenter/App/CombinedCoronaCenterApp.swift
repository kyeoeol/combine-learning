//
//  CombinedCoronaCenterApp.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

@main
struct CombinedCoronaCenterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CoronaCenterViewModel())
        }
    }
}
