//
//  DoubleExtension.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-11.
//

import Foundation

extension Double{
  // with currency symbol
  var withSeperator : String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = "$"
    let newPrice = currencyFormatter.string(from: self as NSNumber)
    return newPrice ?? "0"
  }
  
  // without currency symbol
  var withOutCurrencySeperator : String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = ""
    let newPrice = currencyFormatter.string(from: self as NSNumber)
    return newPrice ?? "0"
  }
  
}

extension Int {
  var withSeperator : String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = ""
    let newPrice = currencyFormatter.string(from: self as NSNumber)
    return newPrice ?? "0"
  }
}
