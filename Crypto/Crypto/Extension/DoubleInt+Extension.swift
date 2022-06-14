//
//  DoubleExtension.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-11.
//

import Foundation

extension Double{
  var withSeperator : String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencySymbol = "$"
    let newPrice = currencyFormatter.string(from: self as NSNumber)
    return newPrice ?? "0"
  }
  
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
