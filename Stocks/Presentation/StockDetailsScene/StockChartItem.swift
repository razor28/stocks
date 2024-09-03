//
//  StockChartItem.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct StockChartItem: Identifiable {
    var id: UUID
    let month: String
    let averagePrice: Double
}
