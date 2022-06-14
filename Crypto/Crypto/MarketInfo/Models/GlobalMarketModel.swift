//
//  GlobalMarketModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-05.
//

import Foundation
//Coin definition
struct GlobalMarketModel: Codable {
  let data: DataModel?
  struct DataModel: Codable {
    let activeCryptoCurrencies: Int?
    let totalMarketCap, totalVolume: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptoCurrencies = "active_cryptocurrencies"
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
    }
  }
}
//Coin definition for our display
struct GlobalMarketViewModel {
  var totalMarketCap: String?
  var activeCryptoCurrencies: String?
  var totalVolume: String?
}

