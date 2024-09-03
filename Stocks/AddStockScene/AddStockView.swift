//
//  AddStockView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import SwiftData

struct AddStockView<ViewModel: AddStockViewModel>: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: ViewModel
    
    @Query(sort: \StockListEntity.ticker) var stocks: [StockListEntity]
    
    @State private var predicate: Predicate<StockListEntity> = .true
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                if viewModel.isLoading {
                    Text("Loading")
                } else {
                    if viewModel.liveStocks.isEmpty {
                        LazyStockList(predicate: predicate) { stock in
                            let stock = StockEntity(ticker: stock.ticker, companyName: stock.companyName)
                            context.insert(stock)
                            dismiss()
                        }
                    } else {
                        LazyVStack {
                            ForEach(viewModel.liveStocks) { stock in
                                StockItemView(commanStock: "\(stock.ticker)|\(stock.name)", selectionAction: {
                                    let stock = StockEntity(ticker: stock.ticker, companyName: stock.name)
                                    context.insert(stock)
                                    dismiss()
                                })
                            }
                        }
                    }
                }
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
        .onChange(of: viewModel.searchText) { old, new in
            viewModel.onSearchChange()
            guard !new.isEmpty else {
                predicate = .true
                return
            }
            let textUppercased = new.uppercased()
            predicate = #Predicate<StockListEntity> {
                return $0.ticker.contains(textUppercased)
            }
        }
    }
}

#Preview {
    AddStockView(viewModel: DefaultAddStockViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))
}

