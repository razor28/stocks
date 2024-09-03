//
//  AddStockViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation
import SwiftData

protocol AddStockViewModelInput {
    func onSearchSubmit()
    func onSearchChange()
}

protocol AddStockViewModelOutput {
    
}

protocol AddStockViewModel: AddStockViewModelInput, AddStockViewModelOutput, ObservableObject {
    var searchText: String { get set }
    var isLoading: Bool { get }
    var liveStocks: [LiveStock] { get }
}

class DefaultAddStockViewModel: AddStockViewModel {
    private let useCase: CommanStockUseCase

    @Published var searchText = ""
    @Published var isLoading: Bool = false
    @Published var liveStocks: [LiveStock] = []

    init(useCase: CommanStockUseCase) {
        self.useCase = useCase
    }

    func onSearchSubmit() {
        isLoading = true
        Task {
            do {
                let liveStocks = try await searchStocks(text: searchText)
                await MainActor.run { [weak self] in
                    self?.liveStocks = liveStocks
                    self?.isLoading = false
                }
            } catch {
                self.isLoading = false
            }
        }
    }

    func onSearchChange() {
        isLoading = false
        liveStocks  = []
    }

    private func searchStocks(text: String) async throws -> [LiveStock] {
        let url = URL(string: "https://api.polygon.io/v3/reference/tickers?type=CS&market=stocks&search=\(text)&active=true&limit=10&apiKey=dlYdG2jvTBRoIj7EogRRg2Z84igwT1af")!

        let request = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: request)

        let infoResponse = try JSONDecoder().decode(LiveStocksResponse.self, from: data)
        return infoResponse.results
    }
}
