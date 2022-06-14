//
//  PortfolioTableViewHelper.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-13.
//

import UIKit
//Protocol definition
protocol PortfolioDelegate: AnyObject {
  func didCryptoSelected(_ vc: UIViewController)
  func didPriceUpdated()
}

class PortfolioTableViewHelper: NSObject {
  weak var delegate: PortfolioDelegate? // delegation variable initialization
  weak var vm: PortfolioViewModel?
  weak var tableView: UITableView?

  init( with tableView: UITableView, vm: PortfolioViewModel) {
    super.init()
    self.tableView = tableView
    self.vm = vm
    
    self.tableView?.delegate = self // set tableview's delegations to our view
    self.tableView?.dataSource = self
    registerCell()
  }
  /// Refresh tableView
  func reloadTable() {
    tableView?.reloadData()
  }
  /// Register the tableView cell to our custom cel
  private func registerCell() {
    tableView?.register(.init(nibName: "PortfolioTableViewCell", bundle: nil), forCellReuseIdentifier: "PortfolioTableViewCell")
  }
}

extension PortfolioTableViewHelper: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let confirm = UIAlertController(title: "Add Coin quantity", message: nil, preferredStyle: .alert)
    confirm.addTextField(configurationHandler: { (textField) in
      textField.placeholder = "0-100"
    })
    let textfield = confirm.textFields?.first
    textfield?.keyboardType = .numberPad
    textfield?.delegate = self
    confirm.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    confirm.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (action) in
      self?.vm?.updateItemQuantity(id: indexPath.row, quantity: Int(confirm.textFields![0].text ?? "0") ?? 0) // call viewmodel func to update item
      self?.delegate?.didPriceUpdated() // call delegation func
      self?.tableView?.reloadData() // reload tableview datas
    }))
    delegate?.didCryptoSelected(confirm)
  }
  
}

extension PortfolioTableViewHelper: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowedCharacters = CharacterSet.decimalDigits
    let characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)  //check if the character  is numeric or not
  }
}

extension PortfolioTableViewHelper: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if PortfolioCoinModelBrain.portfolioCoins.count > 0 && PortfolioCoinModelBrain.portfolioCoins[0].currentprice != nil { // checks if datas are loaded
      return PortfolioCoinModelBrain.portfolioCoins.count
    }else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath) as! PortfolioTableViewCell
    // set cell items attributes
    let rowItem = PortfolioCoinModelBrain.portfolioCoins[indexPath.row]
    let imgUrl = URL(string: rowItem.Image!)
    cell.coinImage.kf.setImage(with: imgUrl)
    cell.coinNameLabel.text = rowItem.name!
    cell.coinPriceLabel.text = rowItem.currentprice?.withSeperator ?? "0"
    cell.quantityLabel.text = rowItem.quantity.withSeperator
    let sumResult: Double = ((rowItem.currentprice ?? 0) * Double(rowItem.quantity))
    cell.coinSumPriceLabel.text = sumResult.withSeperator
    
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    return cell
  }
}

