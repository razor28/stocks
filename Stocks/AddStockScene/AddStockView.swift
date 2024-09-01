//
//  AddStockView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct AddStockView<ViewModel: AddStockViewModel>: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchResults, id: \.self) { commanStock in
                    StockItemView(commanStock: commanStock, selectionAction: {
                        viewModel.didAdd(commanStock: commanStock)
                        dismiss()
                    })
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("Stocks")
        }
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search) {
            viewModel.onSearchSubmit()
        }
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.onSearchChange()
        }
        
    }
}

#Preview {
    AddStockView(viewModel: DefaultAddStockViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))
}

