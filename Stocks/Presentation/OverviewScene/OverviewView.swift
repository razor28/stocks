//
//  OverviewView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        NavigationStack {
            Text("Start")
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: { }, label: {
                    NavigationLink(destination: ListView(viewModel: DefaultListViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))) {
                        Text("List")
                    }
                })
            }
        }
    }
}

#Preview {
    OverviewView()
}
