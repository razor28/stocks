//
//  StocksApp.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import SwiftData

@main
struct StocksApp: App {
    var body: some Scene {
        WindowGroup {
            OverviewView()
        }
        .modelContainer(for: [StockEntity.self])
    }
}
