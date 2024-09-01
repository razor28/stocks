//
//  StockItemView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct StockItemView: View {
    let commanStock: String
    var selectionAction: () -> Void

    var body: some View {
        HStack {
            Text(commanStock)
            Spacer()
            Button(action: selectionAction, label: {
                Text("Add")
            })
        }
    }
}

#Preview {
    StockItemView(commanStock: "APPL | Apple", selectionAction: { })
}
