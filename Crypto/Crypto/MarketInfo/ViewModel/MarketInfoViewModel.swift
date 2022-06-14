//
//  MarketInfoViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import Foundation

class MarketInfoViewModel {
  private var globalService = GlobalMarketService()// global data service initialization
  private var allCoins = CoinService() // all coins service initialization
  var onGlobalItemsChanged: ((GlobalMarketViewModel) -> ())? // coin completetion handlers
  var onCyrptoItemsChanged: (([AllCoinDatas]) -> ())?
  /// This function refresh datas globally and allCoins
  func refreshDatas() {
    fetchDatas()
    fetchGlobals()
  }
  /// Fetch global Coin datas
  func fetchGlobals() {
    globalService.fetchDatas { [weak self] allGlobals in // call fetch data func
      guard let self = self else { return }
      
      switch allGlobals {
      case .success(let globals): // check if result success
        let globalDatas = (globals.data).map { // map received datas our model to easily usable
          GlobalMarketViewModel.init(
            totalMarketCap: $0.totalMarketCap!["usd"]?.withSeperator,
            activeCryptoCurrencies: $0.activeCryptoCurrencies?.withSeperator ?? "0",
            totalVolume: $0.totalVolume!["usd"]?.withSeperator ?? "0")
        }
        
        if globalDatas != nil { // check if it is empty
          self.onGlobalItemsChanged?(globalDatas!) // let viewcontroller know about completion
        }
      case .failure(let error): // check if it is an error
        print(error.localizedDescription)
      }
      
    }
  }
  /// Fetch all coin datas
  func fetchDatas() {
    allCoins.fetchDatas { [weak self] allCoins in // call coin fetch func
      guard let self = self else { return }
      
      switch allCoins {
      case .success(let coins):
        let allCryptos = (coins).map { // map received datas for easily usability
          AllCoinDatas.init(
            id: ($0.id ?? ""),
            symbol: ($0.symbol ?? ""),
            name: ($0.name ??  ""),
            image: ($0.image ?? ""),
            currentPrice: ($0.currentPrice?.withSeperator ?? ""),
            marketCap: ($0.marketCap?.withSeperator ?? ""),
            marketCapRank: ("\($0.marketCapRank ?? 0)"),
            priceChangePercentage24H: ("\(self.getModifiedChange($0.priceChangePercentage24H ?? 0.0))"))
        }
        
        self.onCyrptoItemsChanged?(allCryptos) // let viewcontroller know about completion
        
      case .failure(let error):
        print(error.localizedDescription) // check if it is an error
      }
    }
  }
}

//MARK: - private func
private extension MarketInfoViewModel {
  /// this function changes double to 2 digits number
  func getModifiedChange(_ degree: Double) -> String {
    return String(format: "%.2f", degree)
  }
}
