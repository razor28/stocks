//
//  CommanStockUseCase.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Combine

protocol CommanStockUseCase {
    func add(commanStock: String)
    func delete(commanStock: String)
    func stocksPublisher() -> AnyPublisher<[String], Never>
    func fetchSelectedStocks() -> [String]
}

final class DefaultCommanStockUseCase: CommanStockUseCase {
    private let repository: CommanStockRepository

    init(repository: CommanStockRepository) {
        self.repository = repository
    }

    func add(commanStock: String) {
        repository.add(commanStock: commanStock)
    }

    func delete(commanStock: String) {
        repository.delete(commanStock: commanStock)
    }
    
    func stocksPublisher() -> AnyPublisher<[String], Never> {
        repository.stocksPublisher()
    }

    func fetchSelectedStocks() -> [String] {
        repository.fetchSelectedStocks()
    }
}
