//
//  LiveStock.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct LiveStock: Identifiable, Codable {
    var id: String { ticker }
    let ticker: String
    let name: String
}
