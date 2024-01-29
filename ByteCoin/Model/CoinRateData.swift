//
//  CoinRateData.swift
//  ByteCoin
//
//  Created by Louis on 29/1/2024.
//

import Foundation

struct CoinRateData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
