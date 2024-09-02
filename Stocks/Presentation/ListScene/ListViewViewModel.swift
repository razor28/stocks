//
//  ListViewViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import Combine
import SwiftData

protocol ListViewViewModelInput {
    func onAppear()
    func didDelete(at offsets: IndexSet)
    func didDelete(stock: StockEntity, context: ModelContext)
}

protocol ListViewViewModelOutput {
    
}

protocol ListViewViewModel: ListViewViewModelInput, ListViewViewModelOutput, ObservableObject {

}

final class DefaultListViewModel: ListViewViewModel {
    private let useCase: CommanStockUseCase


    init(useCase: CommanStockUseCase) {
        self.useCase = useCase
    }

    func onAppear() {

    }

    func didDelete(at offsets: IndexSet) {

    }

    func didDelete(stock: StockEntity, context: ModelContext) {
        context.delete(stock)
    }
}
