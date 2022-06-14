//
//  SearchCoinTableViewCell.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import UIKit

class SearchCoinTableViewCell: UITableViewCell {
  // object connections
  @IBOutlet private(set) weak var backgrounLayout: UIView!
  @IBOutlet private(set) weak var cryptoNumberLabel: UILabel!
  @IBOutlet private(set) weak var cryptoImage: UIImageView!
  @IBOutlet private(set) weak var cryptoName: UILabel!
  @IBOutlet private(set) weak var cryptoSymbol: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    backgrounLayout.layer.cornerRadius = 10
  }
}
