//
//  DefaultCommanStockRepository.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation

final class DefaultCommanStockRepository: CommanStockRepository {
    private let key = "FavoriteStocks"

    func add(commanStock: String) {
        var commanStocks: [String] = (UserDefaults.standard.array(forKey: key) as? [String]) ?? []
        commanStocks.append(commanStock)
        UserDefaults.standard.setValue(commanStocks, forKey: key)
    }

}
