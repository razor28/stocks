//
//  AddStockView.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/1/24.
//

import SwiftUI

struct AddStockView: View {
    @Environment(\.dismiss) var dismiss

    let stocks = [
        "AACG|ATA Creativity Global",
        "AADI|Aadi Bioscience, Inc.",
        "AAGR|African Agriculture Holdings Inc."
    ]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("Stocks")
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            print("Did submit search")
        }
    }
    
    var searchResults: [String] {
        searchText.isEmpty ? stocks : stocks.filter { $0.contains(searchText) }
    }
}

#Preview {
    AddStockView()
}

