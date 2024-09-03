//
//  LiveStocksResponse.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct LiveStocksResponse: Codable {
    let results: [LiveStock]
}
