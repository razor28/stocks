//
//  StockListEntity.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftData

@Model
class StockListEntity {
    var ticker: String
    var companyName: String

    var fullNameUppercased: String {
        "\(ticker)|\(companyName)".uppercased()
    }
    
    init(ticker: String, companyName: String) {
        self.ticker = ticker
        self.companyName = companyName
    }
}
