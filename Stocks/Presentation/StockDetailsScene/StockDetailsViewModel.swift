//
//  StockDetailsViewModel.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

protocol StockDetailsViewModelInput {
    func onAppear(ticker: String)
}

protocol StockDetailsViewModelOutput {
    
}

protocol StockDetailsViewModel: StockDetailsViewModelInput, StockDetailsViewModelOutput, ObservableObject {
    var chartItems: [StockChartItem] { get }
}

final class DefaultStockDetailsViewModel: StockDetailsViewModel {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private lazy var monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()

    @Published var chartItems: [StockChartItem] = []

    func onAppear(ticker: String) {
        Task {
            do {
                let chartItems = try await self.fetchHistoricalData(for: ticker)
                await MainActor.run { [weak self] in
                    self?.chartItems = chartItems
                }
            } catch {
                print(error)
            }
        }
    }

    private func fetchHistoricalData(for ticker: String) async throws -> [StockChartItem] {
        let urlStart = "https://api.polygon.io/v2/aggs/ticker/\(ticker)/range/1/month/"
        let urlEnd = "?adjusted=true&sort=asc&apiKey=dlYdG2jvTBRoIj7EogRRg2Z84igwT1af"
        
        let now = Date()
        let weekAgo = Calendar.current.date(byAdding: .month, value: -12 , to: now)!
        let urlMiddle = "\(dateFormatter.string(from: weekAgo))/\(dateFormatter.string(from: now))"
        
        let url = URL(string: "\(urlStart)\(urlMiddle)\(urlEnd)")!

        let request = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: request)

        let infoResponse = try JSONDecoder().decode(InfoResponse.self, from: data)
        var chartItems: [StockChartItem] = []
        for infoItem in infoResponse.results {
            let date = Date(timeIntervalSince1970: infoItem.t/1000.0)
            let month = monthFormatter.string(from: date)
            chartItems.append(StockChartItem(id: UUID(), month: month, averagePrice: infoItem.vw))
        }
        return chartItems
    }
}
