//
//  Stock.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct Stock {
    var ticker: String
    var companyName: String

    init(ticker: String, companyName: String) {
        self.ticker = ticker
        self.companyName = companyName
    }
}
