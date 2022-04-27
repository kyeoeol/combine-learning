//
//  Response.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

struct CoronaCenterResponse: Codable {
    let totalCount: Int
    let data: [CoronaCenter]
}
