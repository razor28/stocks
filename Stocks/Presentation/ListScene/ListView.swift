//
//  ListView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct ListView<ViewModel: ListViewViewModel>: View {
    @State private var showingSheet = false

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.selectedStocks, id: \.self) { commanStock in
                    StockItemView(commanStock: commanStock, selectionAction: {
                    })
                }.onDelete(perform: { indexSet in
                    viewModel.didDelete(at: indexSet)
                })
                
            }.onAppear {
                viewModel.onAppear()
            }
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
    ListView(viewModel: DefaultListViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))
}
