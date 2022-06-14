//
//  MarketInfoHelper.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-12.
//

import UIKit


class MarketInfoCollectionViewHelper: NSObject {
  
  private var globally: GlobalMarketViewModel?
  
  weak var collectionView: UICollectionView?
  
  init( with collectionView: UICollectionView) {
    super.init()
    self.collectionView = collectionView
    self.collectionView?.delegate = self // set collections view delegations to our view
    self.collectionView?.dataSource = self
    registerCell()
  }
  ///This function register cell to our collection view
  private func registerCell() {
    collectionView?.register(.init(nibName: "GlobalInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GlobalInfoCollectionViewCell")
  }
  /// This function set datas of our collection view
  func setItems(_ items: GlobalMarketViewModel) {
    self.globally = items
    collectionView?.reloadData()
  }
  
}
extension MarketInfoCollectionViewHelper: UICollectionViewDelegate {}

extension MarketInfoCollectionViewHelper: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlobalInfoCollectionViewCell", for: indexPath) as! GlobalInfoCollectionViewCell
    if indexPath.row == 0{
      cell.globalInfoHeadLabel.text = "Global Market Cap"
      cell.globalInfoPriceLabel.text = globally?.totalMarketCap
    }else if indexPath.row == 1 {
      cell.globalInfoHeadLabel.text = "24 Hours Volume"
      cell.globalInfoPriceLabel.text = globally?.totalVolume
    }else {
      cell.globalInfoHeadLabel.text = "Active Crypto Currencies"
      cell.globalInfoPriceLabel.text = globally?.activeCryptoCurrencies
    }
    return cell
  }
}

extension MarketInfoCollectionViewHelper: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    .init(top: 0, left: 8, bottom: 0, right: 8) // give padding 8 pixed left and right of the collection view
  }
}
