//
//  MarketInfoTableViewHelper.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-12.
//

import UIKit
import Kingfisher

protocol MarketInfoDelegate: AnyObject {
  func didCryptoSelected(_ vc: UIViewController)
}

class MarketInfoTableViewHelper: NSObject {
  weak var delegate: MarketInfoDelegate?
  private var allCoinsDatas: [AllCoinDatas] = []
  
  weak var vm: MarketInfoViewModel?
  weak var tableView: UITableView?
  
  init( with tableView: UITableView, vm: MarketInfoViewModel) {
    super.init()
    self.tableView = tableView
    self.vm = vm
    
    self.tableView?.delegate = self // get tableview's delegations
    self.tableView?.dataSource = self
    registerCell()
  }
  /// This function register the cell
  private func registerCell() {
    tableView?.register(.init(nibName: "MarketInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MarketInfoTableViewCell")
  }
  /// set our tableview data items
  func setItems(_ items: [AllCoinDatas]) {
    self.allCoinsDatas = items
    tableView?.reloadData()
  }
}

extension MarketInfoTableViewHelper: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let rowItem = allCoinsDatas[indexPath.row]
//    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
//    vc.coinName = rowItem.id
//    vc.modalPresentationStyle = .popover
//    self.delegate?.didCryptoSelected(vc)
  }
}

extension MarketInfoTableViewHelper: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allCoinsDatas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MarketInfoTableViewCell") as! MarketInfoTableViewCell
    let rowItem = allCoinsDatas[indexPath.row]
    let url = URL(string: rowItem.image!)
    cell.cryptoImage.kf.setImage(with: url)
    cell.cryptoName.text = rowItem.name!
    cell.CryptoNo.text = rowItem.marketCapRank
    cell.cryptoShortName.text = rowItem.symbol?.uppercased()
    
    if Double(rowItem.priceChangePercentage24H ?? "0")! > 0.0 {
      cell.changePercentageImage.image = UIImage(systemName: "arrowtriangle.up.fill")
      cell.changePercentage.text = rowItem.priceChangePercentage24H ?? "0"  + "%"
      cell.makeChangeLabelGreen()
      
    } else if Double(rowItem.priceChangePercentage24H ?? "0")! < 0.0{
      cell.changePercentageImage.image = UIImage(systemName: "arrowtriangle.down.fill")
      cell.changePercentage.text = rowItem.priceChangePercentage24H ?? "0"  + "%"
      cell.makeChangeLabelRed()
      
    } else {
      cell.changePercentageImage.image = UIImage(systemName: "arrowtriangle.right.fill")
      cell.changePercentage.text = rowItem.priceChangePercentage24H ?? "0"  + "%"
      cell.makeChangeLabelGray()
    }
    
    cell.priceLabel.text = rowItem.currentPrice
    cell.marketCapPriceLabel.text = rowItem.marketCap
    
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}
