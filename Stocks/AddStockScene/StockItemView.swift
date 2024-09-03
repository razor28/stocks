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
            }).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

#Preview {
    StockItemView(commanStock: "APPL | Apple", selectionAction: { })
}
