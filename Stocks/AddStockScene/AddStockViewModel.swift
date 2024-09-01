//
//  AddStockViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import Foundation

protocol AddStockViewModelInput {
    func onAppear()
    func onSearchSubmit()
    func onSearchChange()
    func didAdd(commanStock: String)
}

protocol AddStockViewModelOutput {
    
}

protocol AddStockViewModel: AddStockViewModelInput, AddStockViewModelOutput, ObservableObject {
    var searchText: String { get set }
    var searchResults: [String] { get }
}

class DefaultAddStockViewModel: AddStockViewModel {
    private var commanStocks: [String] = []
    @Published var searchText = ""
    
    var searchResults: [String] {
        guard !searchText.isEmpty else { return  commanStocks }
        return commanStocks.filter {
            $0.uppercased().contains(searchText.uppercased())
        }
    }

    func onAppear() {
        Task {
            do {
                let url = Bundle.main.url(forResource: "CommanStocks", withExtension: "txt")
                try await readLineByLine(from: url!)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }

    func onSearchSubmit() {
        //TODO: API call search
    }

    func onSearchChange() {
//        searchText.isEmpty ? commanStocks : commanStocks.filter { $0.contains(searchText) }
    }

    func didAdd(commanStock: String) {
        
    }

    private func readLineByLine(from fileUrl: URL) async throws {
        var commanStocks: [String] = []
        for try await line in fileUrl.lines {
            commanStocks.append(line)
        }
        await MainActor.run { [commanStocks] in
            self.commanStocks = commanStocks
        }
    }
}
