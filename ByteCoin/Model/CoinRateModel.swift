//
//  CoinRateModel.swift
//  ByteCoin
//
//  Created by Louis on 29/1/2024.
//

import Foundation

struct CoinRateModel {
    let from: String
    let to: String
    let rate: Double
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
