//
//  ListView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import SwiftData

struct ListView<ViewModel: ListViewViewModel>: View {
    @Environment(\.modelContext) var context
    @State private var showingSheet = false

    @ObservedObject var viewModel: ViewModel
    
    @Query(sort: \StockEntity.ticker) var stocks: [StockEntity] 

    var body: some View {
        NavigationStack {
            List {
                ForEach(stocks, id: \.self) { entity in
                    StockItemView(commanStock: "\(entity.ticker)|\(entity.companyName)", selectionAction: {
                    })
                }.onDelete(perform: { indexSet in
                    for index in indexSet {
                        let entity = stocks[index]
                        viewModel.didDelete(stock: entity, context: context)
                    }
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
