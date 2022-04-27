//
//  CoronaCenterModel.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

struct CoronaCenter: Codable, Identifiable {
    let id: Int
    let centerName: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id = "연번"
        case centerName = "센터명"
        case address = "주소"
    }
}
