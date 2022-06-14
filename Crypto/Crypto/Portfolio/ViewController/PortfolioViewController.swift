//
//  PortfolioViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import UIKit

class PortfolioViewController: UIViewController {
  //Object connections
  @IBOutlet private weak var portfolioBackgroundView: UIView!
  @IBOutlet private weak var currentBalanceLabel: UILabel!
  @IBOutlet private weak var portfoloioTableView: UITableView!
  
  private var tableViewHelper: PortfolioTableViewHelper! // definiton of tableview helper
  private var viewModel = PortfolioViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.updatePortfolioItem { // on viewwill appear update items' prices as it's tab bar item
      self.tableViewHelper.reloadTable()
      self.didPriceUpdated()
    }
  }
  
  func setupController() {
    portfolioBackgroundView.layer.cornerRadius = 10
    tableViewHelper = .init(with: portfoloioTableView, vm: viewModel) // initialize tableviewHelper
    tableViewHelper.delegate = self // set tableviewHelper delegate to our view
  }
}
//MARK: - Protocol Definiton
extension PortfolioViewController: PortfolioDelegate {
  func didPriceUpdated() {
    self.currentBalanceLabel.text = viewModel.calculateSumPrices()
  }
  func didCryptoSelected(_ vc: UIViewController) {
    present(vc, animated: true)
  }
}
