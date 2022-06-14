//
//  SpecificCoinDataService.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-07.
//

import Foundation

class SpecificCoinDataService {
  private let baseUrl: String = "https://api.coingecko.com/api/v3/coins/"
  ///This function returns datas of the given coinName
  func getSpecificCoin(selectedCoin: String, completionBlock: @escaping (Result<SpecificCoinModel, Error>) -> Void) {
    let finalURL = URL(string: "\(baseUrl)\(selectedCoin)?sparkline=true")! // with  this line we compose coinName and sparkline this will give us the graph datas

    URLSession.shared.dataTask(with: finalURL) { data, response, error in
        do {
            if let jsonData = data {
                let decodeData = try JSONDecoder().decode(SpecificCoinModel.self, from: jsonData)
                DispatchQueue.main.async {
                    completionBlock(.success(decodeData)) // works in the main branch and let vc know
                }
            }
        } catch {
            print("Specific coin error: \(error)")
            completionBlock(.failure(error))// works in the main branch and let vc know
        }
    }.resume()
  }
}
