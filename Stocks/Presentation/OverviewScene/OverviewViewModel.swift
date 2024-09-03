//
//  OverviewViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftData

enum StockError: Error {
    case unknown
}

protocol OverviewViewModelInput {
    func onChange(selectedStocks: [StockEntity])
    func onRefresh(selectedStocks: [StockEntity])
    func onReturnForeground(selectedStocks: [StockEntity])
}

protocol OverviewViewModelOutput {
    
}

protocol OverviewViewModel: OverviewViewModelInput, OverviewViewModelOutput, ObservableObject { 
    var stockInfos: [StockInfo] { get }
}

final class DefaultOverviewViewModel: OverviewViewModel {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    @Published var stockInfos: [StockInfo] = []

    func onChange(selectedStocks: [StockEntity]) {
        fetchInfos(for: selectedStocks)
    }

    func onRefresh(selectedStocks: [StockEntity]) {
        fetchInfos(for: selectedStocks)
    }

    func onReturnForeground(selectedStocks: [StockEntity]) {
        fetchInfos(for: selectedStocks)
    }

    private func fetchInfos(for selectedStocks: [StockEntity]) {
        let tickers: [String] = selectedStocks.map { $0.ticker }.sorted()
        Task {
            do {
                let infos = try await withThrowingTaskGroup(of: StockInfo.self, returning: [StockInfo].self) { taskGroup in
                    for ticker in tickers {
                        taskGroup.addTask { try await self.fetchInfo(for: ticker) }
                    }
                    var infos: [StockInfo] = []
                    for try await result in taskGroup {
                        infos.append(result)
                       }
                       return infos
                }
                await MainActor.run { [weak self] in
                    self?.stockInfos = infos
                }
            } catch {
                
            }
        }
    }

    private func fetchInfo(for ticker: String) async throws -> StockInfo {
        //create the new url
        let urlStart = "https://api.polygon.io/v2/aggs/ticker/\(ticker)/range/1/day/"
        let urlEnd = "?adjusted=true&sort=desc&apiKey=dlYdG2jvTBRoIj7EogRRg2Z84igwT1af"
        
        let now = Date()
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7 , to: now)!
        let urlMiddle = "\(dateFormatter.string(from: weekAgo))/\(dateFormatter.string(from: now))"
        
        let url = URL(string: "\(urlStart)\(urlMiddle)\(urlEnd)")!

        let request = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: request)
        
        //checks if there are errors regarding the HTTP status code and decodes using the passed struct
        let infoResponse = try JSONDecoder().decode(InfoResponse.self, from: data)
        guard infoResponse.results.count >= 2 else { throw StockError.unknown }
        let first = infoResponse.results[0]
        let second = infoResponse.results[1]
        return StockInfo(
            id: UUID(),
            ticker: ticker,
            currentPrice: first.vw,
            dailyChange: (first.vw-second.vw)/second.vw
        )
    }
}
