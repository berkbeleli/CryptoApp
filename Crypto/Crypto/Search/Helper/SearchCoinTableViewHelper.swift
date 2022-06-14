//
//  SearchCryptoHelper.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//


import UIKit
// Protocol definition
protocol SearchCoinDelegate: AnyObject {
  func didCryptoSelected(_ vc: UIViewController)
}


class SearchCoinTableViewHelper: NSObject {
  weak var delegate: SearchCoinDelegate? // delegation variable
  private var searchCoinDatas: [SeachCoin] = []
  
  weak var vm: SearchCoinViewModel?
  weak var tableView: UITableView?
  init( with tableView: UITableView, vm: SearchCoinViewModel) {
    super.init()
    self.tableView = tableView
    self.vm = vm
    
    self.tableView?.delegate = self // set tableview's delegation to our view
    self.tableView?.dataSource = self
    registerCell()
  }
  ///This func will set customcell to our view
  private func registerCell() {
    tableView?.register(.init(nibName: "SearchCoinTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCoinTableViewCell")
  }
  /// Set tableViewData source
  func setItems(_ items: [SeachCoin]) {
    self.searchCoinDatas = items
    tableView?.reloadData()
  }
}

extension SearchCoinTableViewHelper: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let rowItem = searchCoinDatas[indexPath.row]
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController // instantiate vc

    vc.coinName = rowItem.id
    vc.modalPresentationStyle = .popover
    self.delegate?.didCryptoSelected(vc) // call delegation func
  }
}

extension SearchCoinTableViewHelper: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchCoinDatas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCoinTableViewCell", for: indexPath) as! SearchCoinTableViewCell
    //set our tableview's cell attributes
    let rowItem = searchCoinDatas[indexPath.row]
    cell.cryptoNumberLabel.text = rowItem.marketCapRank ?? "0"
    let imageUrl = URL(string: (rowItem.largeImage)!)
    cell.cryptoImage.kf.setImage(with: imageUrl)
    cell.cryptoName.text = rowItem.name
    cell.cryptoSymbol.text = rowItem.symbol
    
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}

