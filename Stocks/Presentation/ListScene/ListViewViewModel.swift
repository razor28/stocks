//
//  ListViewViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI
import Combine

protocol ListViewViewModelInput {
    func onAppear()
    func didDelete(at offsets: IndexSet)
}

protocol ListViewViewModelOutput {
    
}

protocol ListViewViewModel: ListViewViewModelInput, ListViewViewModelOutput, ObservableObject {
    var selectedStocks: [String] { get }
}

final class DefaultListViewModel: ListViewViewModel {
    private let useCase: CommanStockUseCase
    private var bag = Set<AnyCancellable>()

    @Published var selectedStocks: [String] = []

    init(useCase: CommanStockUseCase) {
        self.useCase = useCase
    }

    func onAppear() {
        useCase
            .stocksPublisher()
            .receive(on: DispatchQueue.main)
            .sink { values in
                self.selectedStocks = values
            }
            .store(in: &bag)
    }

    func didDelete(at offsets: IndexSet) {
        let toDelete = offsets.map { selectedStocks[$0] }
        guard let first = toDelete.first else { return }
        useCase.delete(commanStock: first)
        selectedStocks.remove(atOffsets: offsets)
    }
}
