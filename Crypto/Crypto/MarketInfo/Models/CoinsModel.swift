//
//  CoinsModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-06.
//

import Foundation

//MARK: - Coin Model Definition
struct CoinsModel: Codable {
  var id: String?
  var symbol: String?
  var name: String?
  var image: String?
  var currentPrice: Double? = 0
  var marketCap: Int? = 0
  var marketCapRank: Int? = 0
  var priceChangePercentage24H: Double? = 0

  enum CodingKeys: String, CodingKey {
      case id
      case symbol
      case name
      case image
      case currentPrice = "current_price"
      case marketCap = "market_cap"
      case marketCapRank = "market_cap_rank"
      case priceChangePercentage24H = "price_change_percentage_24h"
  }
}
//MARK: - Coin definition for our display
struct AllCoinDatas {
  var id: String?
  var symbol: String?
  var name: String?
  var image: String?
  var currentPrice: String?
  var marketCap: String?
  var marketCapRank: String?
  var priceChangePercentage24H: String?
}

