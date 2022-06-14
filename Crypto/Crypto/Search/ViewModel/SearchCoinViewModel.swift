//
//  SearchCoinViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import Foundation

class SearchCoinViewModel {
  private var specificCoinDataService = SearchCoinDataService() // data service definition
  var onSearchItemsChanged: (([SeachCoin]) -> ())?
  /// fetch cryptos according to entered word
  func fetchCryptos(_ coinName: String) {
    
    specificCoinDataService.getCoins(searchedCoin: coinName) { [weak self] searchedCoin in
      guard let self = self else { return }
      
      switch searchedCoin {
      case .success(let searchedCoin):
        let searchedCryptos = (searchedCoin.coins ?? []).map { // map fetched data to our viewer model
          SeachCoin.init(id: $0.id ?? "", name: $0.name ?? "", symbol: $0.symbol ?? "", marketCapRank: "\($0.marketCapRank ?? 0)", largeImage: $0.largeImage ?? "")
        }
        self.onSearchItemsChanged?(searchedCryptos) //  let main branch know items have fetched
      case .failure(let error):
        print(error.localizedDescription) // let main branch know there is an error
      }
    }
  }
}
