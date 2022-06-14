//
//  SearchCoinDataService.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import Foundation

class SearchCoinDataService {

    private let baseURL: String = "https://api.coingecko.com/api/v3/search?query="
    ///this function calls the url according to user's entered word
    func getCoins(searchedCoin: String, completionBlock: @escaping (Result<SearchCoinModel, Error>) -> Void) {
        let finalURL = URL(string: baseURL + searchedCoin)! // compose url and searched text
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            do {
                if let jsonData = data { // check if data exist
                    let decodeData = try JSONDecoder().decode(SearchCoinModel.self, from: jsonData) // decode data
                    DispatchQueue.main.async {
                        completionBlock(.success(decodeData)) // let our main branch know the fetch is over
                    }
                }
            } catch {
                print("Error: \(error)")
                completionBlock(.failure(error))
            }
        }.resume()
    }
}
