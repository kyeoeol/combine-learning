//
//  CoronaError.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

enum CoronaError: Error {
    case parsing(description: String)
    case network(description: String)
}
