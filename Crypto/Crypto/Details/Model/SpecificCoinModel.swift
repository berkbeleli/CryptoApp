//
//  SpecificCoinModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-07.
//

struct SpecificCoinModel: Codable {
    var id: String? = ""
    var symbol: String? = ""
    var name: String? = ""
    var coinModelDescription: Lang?
    var image: AssetImage?
    var marketCapRank: Int? = 0
    var marketData: MarketData?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case coinModelDescription = "description"
        case image
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
    }
}

// MARK: - Tion
struct Lang: Codable {
    var en: String? = ""
}

// MARK: - Image
struct AssetImage: Codable  {
    var thumb: String? = "", small: String? = "", large: String? = ""
}

// MARK: - MarketData
struct MarketData: Codable  {
    var currentPrice: [String: Double] = [:]
    var ath: [String: Double] = [:]
    var atl: [String: Double] = [:]
    var marketCap: [String: Double] = [:]
    var marketCapRank: Int? = 0
    var totalVolume: [String: Double] = [:], high24H: [String: Double] = [:], low24H: [String: Double] = [:]
    var priceChangePercentage24H: Double? = 0
    var totalSupply, maxSupply, circulatingSupply: Double?
    var sparkline7D: Sparkline7D?
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
        case atl
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case sparkline7D = "sparkline_7d"
    }
}

struct Sparkline7D: Codable {
    var price: [Double]? = []
    enum CodingKeys: String, CodingKey {
        case price
    }
}

struct SpecificViewViewModel{
  var id: String?
  var symbol: String?
  var name: String?
  var description: String?
  var image: String?
  var marketCapRank: String?
  var currentPrice: String?
  var ath: String?
  var atl: String?
  var marketCap: String?
  var totalVolume: String?
  var high24h: String?
  var low24h: String?
  var priceChangePercentage: String?
  var maxSupply: String?
  var totalSupply: String?
  var circulatingSupply: String?
  var lineDatas: [Double]?
}
