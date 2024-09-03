//
//  File.swift
//  Stocks
//
//  Created by Dastan Tashimbetov on 9/2/24.
//

import Foundation

struct InfoResponse: Codable {
    let ticker: String
    let results: [InfoResult]
}

struct InfoResult: Codable {
    let c: Double
    let h: Double
    let l: Double
    let n: Double
    let o: Double
    let t: Double
    let v: Double
    let vw: Double
}
