//
//  CostumTableViewCell.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-06.
//

import UIKit

class MarketInfoTableViewCell: UITableViewCell {
  // create connections
  @IBOutlet private weak var bgView: UIView!
  @IBOutlet private(set) weak var cryptoImage: UIImageView!
  @IBOutlet private(set) weak var cryptoName: UILabel!
  @IBOutlet private(set) weak var CryptoNo: UILabel!
  @IBOutlet private(set) weak var cryptoShortName: UILabel!
  @IBOutlet private(set) weak var changePercentageImage: UIImageView!
  @IBOutlet private(set) weak var changePercentage: UILabel!
  @IBOutlet private(set) weak var priceLabel: UILabel!
  @IBOutlet private(set) weak var marketCapLabel: UILabel!
  @IBOutlet private(set) weak var marketCapPriceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    bgView.layer.cornerRadius = 10
    marketCapLabel.text = "M.Cap:"
  }
  /// set change percentage and its image red
  func makeChangeLabelRed() {
    changePercentage.textColor = .red
    changePercentageImage.tintColor = .red
  }
  /// set change percentage and its image green
  func makeChangeLabelGreen() {
    changePercentage.textColor = .green
    changePercentageImage.tintColor = .green
  }
  /// set change percentage and its image gray
  func makeChangeLabelGray() {
    changePercentage.textColor = .gray
    changePercentageImage.tintColor = .gray
  }
}
