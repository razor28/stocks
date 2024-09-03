//
//  StockDetailsView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftUI
import Charts

struct StockDetailsView<ViewModel: StockDetailsViewModel>: View {
    let ticker: String

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GroupBox("Average Price") {
            Chart {
                ForEach(viewModel.chartItems) {
                    BarMark(
                        x: .value("Month", $0.month),
                        y: .value("Price", $0.averagePrice)
                    )
                }
            }
        }
        .onAppear {
            viewModel.onAppear(ticker: ticker)
        }
        .navigationTitle(ticker)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StockDetailsView(ticker: "AAPL", viewModel: DefaultStockDetailsViewModel())
}
