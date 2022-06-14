//
//  SearchCoinModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import Foundation
// Search Coin model
struct SearchCoinModel: Codable {
  var coins: [SearchCoin]?
  
  struct SearchCoin: Codable {
    var id: String?
    var name: String?
    var symbol: String?
    var marketCapRank: Int?
    var largeImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case marketCapRank = "market_cap_rank"
        case largeImage = "large"
    }
  }
}
// SearchCoin View Model
struct SeachCoin {
  var id: String?
  var name: String?
  var symbol: String?
  var marketCapRank: String?
  var largeImage: String?
}
