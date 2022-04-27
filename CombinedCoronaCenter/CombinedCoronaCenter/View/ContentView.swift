//
//  ContentView.swift
//  CombinedCoronaCenter
//
//  Created by haanwave on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @ObservedObject var viewModel: CoronaCenterViewModel
   
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.coronaCenters) { center in
                    CoronaCenterItemView(center: center)
                        .padding(.horizontal)
                }
            } //: ScrollView
            .navigationTitle("코로나 19 센터 리스트")
        } //: NavigationView
        .onAppear {
            viewModel.fetchCoronaCenter()
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CoronaCenterViewModel())
    }
}
