//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import Foundation
import Charts
//Protocol Definition
protocol DetailViewProtocol: AnyObject {
  func addedToPortfolio()
  func deletedFromPortfolio()
}

class DetailViewModel {
  private var specificCoinDataService = SpecificCoinDataService()
  var onSpecificCoinLoaded: ((SpecificViewViewModel) -> ())?
  var coin: SpecificViewViewModel?
  weak var delegate: DetailViewProtocol? // create delegate variable
  ///This func call the specificCoin Datas
  func fetchSpecificCoinDatas(_ coinName: String) {
    specificCoinDataService.getSpecificCoin(selectedCoin: coinName) { [weak self] coinDatas in
      guard let self = self else { return }
      
      switch coinDatas {
      case .success(let coinDatas):
        let specificCoin = SpecificViewViewModel( // map received data to our viewmodal object
          id: coinDatas.id ?? "",
          symbol: coinDatas.symbol?.uppercased() ?? "",
          name: coinDatas.name ?? "",
          description: coinDatas.coinModelDescription?.en ?? "No Description",
          image: coinDatas.image?.small ?? "",
          marketCapRank: "\(coinDatas.marketCapRank ?? 0)",
          currentPrice: coinDatas.marketData?.currentPrice["usd"]?.withSeperator ?? "0",
          ath: coinDatas.marketData?.ath["usd"]?.withSeperator ?? "0",
          atl: coinDatas.marketData?.atl["usd"]?.withSeperator ?? "0",
          marketCap: coinDatas.marketData?.marketCap["usd"]?.withSeperator ?? "0",
          totalVolume: coinDatas.marketData?.totalVolume["usd"]?.withSeperator ?? "0",
          high24h: coinDatas.marketData?.high24H["usd"]?.withSeperator ?? "0",
          low24h: coinDatas.marketData?.low24H["usd"]?.withSeperator ?? "0",
          priceChangePercentage: self.getModifiedChange(coinDatas.marketData?.priceChangePercentage24H ?? 0.0) ,
          maxSupply: coinDatas.marketData?.maxSupply?.withOutCurrencySeperator ?? "∞",
          totalSupply: coinDatas.marketData?.totalSupply?.withOutCurrencySeperator ?? "∞",
          circulatingSupply: coinDatas.marketData?.circulatingSupply?.withOutCurrencySeperator ?? "0",
          lineDatas: coinDatas.marketData?.sparkline7D?.price ?? [])
        
          self.onSpecificCoinLoaded?(specificCoin) // send converted object to our vc
          self.coin = specificCoin // it will be used to check if item in portfolio
        
      case .failure(let error):
        print(error.localizedDescription)
      }
  
    }
  }
  /// This function will create graphLines
  func createGraphLines(_ prices: [Double]) -> LineChartData {
    var lineChartEntry = [ChartDataEntry]()
    var counter = 1 // it will hold x value of the graph
    for price in prices {
      let value = ChartDataEntry(x: Double(counter), y: price)
      counter += 1
      lineChartEntry.append(value)
    }
    let line1 = LineChartDataSet(entries: lineChartEntry, label: "")
    line1.colors = prices[0] < prices[prices.count-1] ? [NSUIColor.green] : [NSUIColor.red]
    line1.drawCirclesEnabled = false
    let data = LineChartData()
    data.addDataSet(line1)
    return data
    
  }
  /// Check if item in the portfolio
  func checkItemInPortfolio(_ coinID: String) -> Bool {
    if PortfolioCoinModelBrain.portfolioCoins.count > 0 && PortfolioCoinModelBrain.checkItemExists(item: PortfolioCoinModel(id: coinID)) {
       return true
      }
    return false
  }
  /// Add or remove item from the portfolio
  func addToPortfolioClicked() {
    
    if let coin = coin {
      let coinModel = PortfolioCoinModel(id: coin.id!)
      if PortfolioCoinModelBrain.checkItemExists(item: coinModel){
        PortfolioCoinModelBrain.deleteItem(item: coinModel) // remove item
        delegate?.deletedFromPortfolio() // call delegate func
      }else {
        PortfolioCoinModelBrain.addItem(item: PortfolioCoinModel(id: coin.id!, addedToPortfolio: true, Image: coin.image, name: coin.name)) // add item
        delegate?.addedToPortfolio()// call delegate func
      }
    }
  }
}

//MARK: - private func
private extension DetailViewModel {
  func getModifiedChange(_ degree: Double) -> String {
    return String(format: "%.2f", degree)
  }
}
