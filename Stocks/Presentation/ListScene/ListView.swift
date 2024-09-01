//
//  ListView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct ListView: View {
    @State private var showingSheet = false

    var body: some View {
        NavigationStack {
            Text("listView")
                .navigationTitle("List of Stocks")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Add") {
                        showingSheet.toggle()
                    }
                    .fullScreenCover(isPresented: $showingSheet) {
                        AddStockView(viewModel: DefaultAddStockViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))
                    }
                }
        }
    }
}

#Preview {
    ListView()
}
