//
//  DefaultCommanStockRepository.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation
import Combine

final class DefaultCommanStockRepository: CommanStockRepository {
    private let key = "FavoriteStocks"

    func add(commanStock: String) {
        var commanStocks: [String] = (UserDefaults.standard.array(forKey: key) as? [String]) ?? []
        commanStocks.append(commanStock)
        UserDefaults.standard.setValue(commanStocks, forKey: key)
    }

    func delete(commanStock: String) {
        var commanStocks: [String] = (UserDefaults.standard.array(forKey: key) as? [String]) ?? []
        commanStocks.removeAll(where: { $0 == commanStock })
        UserDefaults.standard.setValue(commanStocks, forKey: key)
    }

    func stocksPublisher() -> AnyPublisher<[String], Never> {
        UserDefaults
            .standard
            .publisher(for: \.commanStocks, options: [.new, .initial])
            .eraseToAnyPublisher()
    }

    func fetchSelectedStocks() -> [String] {
        (UserDefaults.standard.array(forKey: key) as? [String]) ?? []
    }
}

extension UserDefaults {
    @objc dynamic var commanStocks: [String] {
        return (array(forKey: "FavoriteStocks") as? [String]) ?? []
    }
}

