//
//  CoinService.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-06.
//

import Foundation

class CoinService {
  /// This function fetch top 100 coins
  func fetchDatas( completionBlock: @escaping (Result<[CoinsModel], Error>) -> Void) {
    
    if let url = URL.init(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"){
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        do{
          guard let data = data else { // check if data exists
            return
          }
          let decodeData = try JSONDecoder().decode([CoinsModel].self, from: data) // decode data according to our model
          DispatchQueue.main.async {
            completionBlock(.success(decodeData)) // in main bracnh send completed item
          }
        }catch{
          print("Specific coin error: \(error)")
          completionBlock(.failure(error)) // send error
        }
      }
      task.resume()
    }
  }
}
