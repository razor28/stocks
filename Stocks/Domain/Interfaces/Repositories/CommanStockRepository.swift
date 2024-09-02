//
//  CommanStockRepository.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation
import Combine

protocol CommanStockRepository {
    func add(commanStock: String)
    func delete(commanStock: String)
    func stocksPublisher() -> AnyPublisher<[String], Never>
    func fetchSelectedStocks() -> [String]
}
