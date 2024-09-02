//
//  DefaultCommanStockRepository.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation
import Combine
import SwiftData

final class DefaultCommanStockRepository: CommanStockRepository {
    func add(commanStock: String) {

    }

    func delete(commanStock: String) {

    }

    func stocksPublisher() -> AnyPublisher<[String], Never> {
        UserDefaults
            .standard
            .publisher(for: \.commanStocks, options: [.new, .initial])
            .eraseToAnyPublisher()
    }

    func fetchSelectedStocks() -> [String] {
        return []
    }

    func add(stock: Stock) {
        
    }
}

extension UserDefaults {
    @objc dynamic var commanStocks: [String] {
        return (array(forKey: "FavoriteStocks") as? [String]) ?? []
    }
}

private extension Stock {
    var stockEntity: StockEntity {
        StockEntity(ticker: ticker, companyName: companyName)
    }
}
