//
//  LazyStockList.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation
import SwiftUI
import SwiftData

struct LazyStockList: View {
    @Query(sort: \StockListEntity.ticker) var stocks: [StockListEntity]
    
    let selectionAction: (StockListEntity) -> Void
    
    init(predicate: Predicate<StockListEntity>, selectionAction: @escaping(StockListEntity) -> Void) {
        _stocks = Query(filter: predicate)
        self.selectionAction = selectionAction
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(stocks, id: \.self) { stock in
                    StockItemView(commanStock: "\(stock.ticker)|\(stock.companyName)", selectionAction: {
                        selectionAction(stock)
                    })
                }
            }
        }
    }
}
