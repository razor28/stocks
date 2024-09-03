//
//  StockInfoView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftUI

struct StockInfoView: View {
    let stockInfo: StockInfo

    var body: some View {
        Text("\(stockInfo.ticker)|$\(stockInfo.currentPrice)|\(stockInfo.dailyChange)")
    }
}

#Preview {
    StockInfoView(stockInfo: StockInfo(id: UUID(), ticker: "AAPL", currentPrice: 200, dailyChange: 0.1))
}
