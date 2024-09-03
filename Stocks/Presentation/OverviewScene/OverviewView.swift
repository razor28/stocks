//
//  OverviewView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import SwiftData

struct OverviewView: View {
    @Environment(\.modelContext) var context

    @Query(sort: \StockListEntity.ticker) var stocks: [StockListEntity]

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
            .onAppear {
                if stocks.isEmpty {
                    preceedStockList()
                }
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
    OverviewView()
}
