//
//  CoronaCenterItemView.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

struct CoronaCenterItemView: View {
    // MARK: - PROPERTIES
    
    let center: CoronaCenter
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(center.centerName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(center.address)
                    .font(.footnote)
            } //: VStack
            
            Spacer()
        } //: HStack
        .padding(20)
        .background(.gray.opacity(0.5))
        .cornerRadius(12)
    }
}

// MARK: - PREVIEW

struct CoronaCenterItemView_Previews: PreviewProvider {
    static var previews: some View {
        let center = CoronaCenter(id: 1, centerName: "OOOO 센터", address: "OOO시 OOO구 OOO동")
        CoronaCenterItemView(center: center)
    }
}
