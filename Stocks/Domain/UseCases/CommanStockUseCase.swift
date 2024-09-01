//
//  CommanStockUseCase.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation

protocol CommanStockUseCase {
    func add(commanStock: String)
}

final class DefaultCommanStockUseCase: CommanStockUseCase {
    private let repository: CommanStockRepository

    init(repository: CommanStockRepository) {
        self.repository = repository
    }

    func add(commanStock: String) {
        repository.add(commanStock: commanStock)
    }
    
    
}
