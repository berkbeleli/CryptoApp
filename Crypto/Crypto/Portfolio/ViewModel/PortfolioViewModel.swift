//
//  PortfolioViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import Foundation

class PortfolioViewModel {
  private var specificCoinDataService = SpecificCoinDataService()
  
  func updatePortfolioItem(completion: @escaping(() -> ())) {
    if PortfolioCoinModelBrain.portfolioCoins.count > 0 {
      for i in 0..<PortfolioCoinModelBrain.portfolioCoins.count {
        
        specificCoinDataService.getSpecificCoin(selectedCoin: PortfolioCoinModelBrain.portfolioCoins[i].id) { speficificCoin in
          
          switch speficificCoin {
          case .success(let coinModel):
            PortfolioCoinModelBrain.portfolioCoins[i].currentprice = coinModel.marketData?.currentPrice["usd"] ?? 0.0
            if(i == PortfolioCoinModelBrain.portfolioCoins.count - 1) {
              completion()
            }
            
          case .failure(let error):
            print(error.localizedDescription)
          }
          
        }
      }
    } else {
      completion()
    }
  }
  
  func calculateSumPrices() -> String {
    var price: Double = 0.0
    
    for portfolioCoin in PortfolioCoinModelBrain.portfolioCoins {
      price += (portfolioCoin.currentprice ?? 0.0) * Double(portfolioCoin.quantity)
    }
    return "\(price.withSeperator)"
  }
  
  func updateItemQuantity(id: Int, quantity: Int) {
    PortfolioCoinModelBrain.updateItem(id: PortfolioCoinModelBrain.portfolioCoins[id].id, quantity: quantity)
  }
  
}
