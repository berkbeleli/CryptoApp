//
//  CustomCollectionViewCell.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-09.
//

import UIKit

class GlobalInfoCollectionViewCell: UICollectionViewCell {
  // connections
  @IBOutlet private(set) weak var bgView: UIView!
  @IBOutlet private(set) weak var globalInfoHeadLabel: UILabel!
  @IBOutlet private(set) weak var globalInfoPriceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  private func setupUI() {
    bgView.layer.cornerRadius = 10
  }
}
