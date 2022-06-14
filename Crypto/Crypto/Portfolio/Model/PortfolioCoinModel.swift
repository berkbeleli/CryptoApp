//
//  PortfolioCoinModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-09.
//

import Foundation
// Portfolio Coin Model
struct PortfolioCoinModel {
  var id: String
  var addedToPortfolio: Bool? = false
  var quantity: Int = 0
  var Image: String?
  var name: String?
  var currentprice: Double?
}
