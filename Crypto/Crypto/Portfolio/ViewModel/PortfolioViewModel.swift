//
//  PortfolioViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import Foundation

class PortfolioViewModel {
  private var specificCoinDataService = SpecificCoinDataService() // data service initialization
  /// Update portfolio Items' prices
  func updatePortfolioItem(completion: @escaping(() -> ())) {
    if PortfolioCoinModelBrain.portfolioCoins.count > 0 { // check count's of the portfolio items
      for i in 0..<PortfolioCoinModelBrain.portfolioCoins.count {
        specificCoinDataService.getSpecificCoin(selectedCoin: PortfolioCoinModelBrain.portfolioCoins[i].id) { speficificCoin in // call api according to current portfolio item
          
          switch speficificCoin {
          case .success(let coinModel):
            PortfolioCoinModelBrain.portfolioCoins[i].currentprice = coinModel.marketData?.currentPrice["usd"] ?? 0.0 // get usd price and set it to the item's price
            if(i == PortfolioCoinModelBrain.portfolioCoins.count - 1) {
              completion() // if all of the item's completed call completion
            }
          case .failure(let error):
            print(error.localizedDescription) // let people know there is an error
          }
          
        }
      }
    } else {
      completion() // if item inn the portfolio equal 0 we let vc know about it
    }
  }
  /// Calculates Portfolio Item Prices
  func calculateSumPrices() -> String {
    var price: Double = 0.0
    for portfolioCoin in PortfolioCoinModelBrain.portfolioCoins {
      price += (portfolioCoin.currentprice ?? 0.0) * Double(portfolioCoin.quantity)
    }
    return "\(price.withSeperator)"
  }
  ///Update Item Quantity
  func updateItemQuantity(id: Int, quantity: Int) {
    PortfolioCoinModelBrain.updateItem(id: PortfolioCoinModelBrain.portfolioCoins[id].id, quantity: quantity)
  }
  
}
