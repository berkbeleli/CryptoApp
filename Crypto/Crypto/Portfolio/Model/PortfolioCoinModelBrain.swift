//
//  PortfolioCoinModelBrain.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-09.
//

import Foundation

struct PortfolioCoinModelBrain {
  static var portfolioCoins: [PortfolioCoinModel] = [] // hold of the portfolio items
  /// Add item to portfolio
  static func addItem(item: PortfolioCoinModel) {
    portfolioCoins.append(item)
  }
  // remove item from portfolio
  static func deleteItem(item: PortfolioCoinModel) {
    if let index = portfolioCoins.lastIndex(where: { $0.id == item.id}) {
      portfolioCoins.remove(at: index)
    }
  }
  /// update item quantity
  static func updateItem(id: String, quantity: Int) {
    if let index = portfolioCoins.lastIndex(where: { $0.id == id}) {
      portfolioCoins[index].quantity = quantity
    }
  }
  /// checks if the item  exist in the portfolio array
  static func checkItemExists(item: PortfolioCoinModel) -> Bool {
    portfolioCoins.contains { $0.id == item.id }
  }
}
