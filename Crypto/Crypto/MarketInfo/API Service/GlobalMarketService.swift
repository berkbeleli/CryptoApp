//
//  GlobalMarketService.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-05.
//

import Foundation

class GlobalMarketService {
  // This function fetch global datas
  func fetchDatas( completionBlock: @escaping (Result<GlobalMarketModel, Error>) -> Void) {
    
    if let url = URL.init(string: "https://api.coingecko.com/api/v3/global"){

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        do{
          guard let data = data else { // check if data exists
            return
          }
          let decodeData = try JSONDecoder().decode(GlobalMarketModel.self, from: data) // decode data according to our model
          DispatchQueue.main.async {
            completionBlock(.success(decodeData)) // send data in main bracnh
          }
        }catch{
          print("Global error: \(error)")
          completionBlock(.failure(error)) // send received error
        }
      }
      task.resume()
    }
  }
}
