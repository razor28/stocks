//
//  File.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct StockInfo: Identifiable, Codable {
    let id: UUID
    let ticker: String
    let currentPrice: Double
    let dailyChange: Double
}
