//
//  OverviewView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import SwiftData

struct OverviewView<ViewModel: OverviewViewModel>: View {
    @Environment(\.modelContext) var context
    @Environment(\.scenePhase) var scenePhase

    @Query(sort: \StockListEntity.ticker) var stocks: [StockListEntity]
    @Query(sort: \StockEntity.ticker) var selectedStocks: [StockEntity]

    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.stockInfos) { info in
                NavigationLink {
                    StockDetailsView(ticker: info.ticker, viewModel: DefaultStockDetailsViewModel())
                } label: {
                    Text("\(info.ticker)|$\(info.currentPrice)|\(info.dailyChange)")
                }
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: { }, label: {
                    NavigationLink(destination: ListView(viewModel: DefaultListViewModel(useCase: DefaultCommanStockUseCase(repository: DefaultCommanStockRepository())))) {
                        Text("List")
                    }
                })
            }
            .onAppear {
                if stocks.isEmpty {
                    preceedStockList()
                }
            }
            .refreshable {
                viewModel.onRefresh(selectedStocks: selectedStocks)
            }
            .onChange(of: selectedStocks) {
                viewModel.onChange(selectedStocks: selectedStocks)
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                guard newPhase == .active else { return }
                viewModel.onReturnForeground(selectedStocks: selectedStocks)
            }
        }
    }

    private func preceedStockList() {
        Task {
            do {
                let url = Bundle.main.url(forResource: "CommanStocks", withExtension: "txt")
                for try await line in url!.lines {
                    let parts = line.split(separator: "|")
                    if
                        let ticker = parts.first,
                        let name = parts.last {
                        await MainActor.run {
                            let entity = StockListEntity(
                                ticker: String(ticker),
                                companyName: String(name)
                            )
                            self.context.insert(entity)
                        }
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

#Preview {
    OverviewView(viewModel: DefaultOverviewViewModel())
}
