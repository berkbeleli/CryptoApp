//
//  PortfolioTableViewCell.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
  // object connections
  @IBOutlet private(set) weak var backgroundLayout: UIView!
  @IBOutlet private(set) weak var coinImage: UIImageView!
  @IBOutlet private(set) weak var coinNameLabel: UILabel!
  @IBOutlet private(set) weak var coinPriceLabel: UILabel!
  @IBOutlet private(set) weak var coinSumPriceLabel: UILabel!
  @IBOutlet private(set) weak var quantityLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    backgroundLayout.layer.cornerRadius = 10
  }
}
