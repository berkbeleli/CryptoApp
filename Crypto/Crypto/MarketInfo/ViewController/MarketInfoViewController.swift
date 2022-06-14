//
//  ViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-05.
//

import UIKit

class MarketInfoViewController: UIViewController {
  //created connections
  @IBOutlet private weak var collectionVieww: UICollectionView!
  @IBOutlet private weak var tableVieww: UITableView!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  
  private var refreshControl: UIRefreshControl? // refresh control for pull to refresh
  private var viewModel = MarketInfoViewModel()
  private var collectionViewHelper: MarketInfoCollectionViewHelper!
  private var tableViewHelper: MarketInfoTableViewHelper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refreshControl = UIRefreshControl()
    tableVieww.addSubview(refreshControl!)
    refreshControl!.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged) // ad table view pull to refresh action
    setupController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.refreshDatas()
  }
  
  private func setupController() {
    refreshControl?.tintColor = .red
    collectionViewHelper = .init(with: collectionVieww) // send helper our collectionview
    tableViewHelper = .init(with: tableVieww, vm: viewModel) // send helper our tableview
    tableViewHelper.delegate = self // get tableview's delegate
    activityIndicator.startAnimating() // start activity indicator
    viewModel.onGlobalItemsChanged = { [weak self] data in
      self?.collectionViewHelper.setItems(data) // set helperview datas
    }
    
    viewModel.onCyrptoItemsChanged = { [weak self] cryptos in
      self?.tableViewHelper.setItems(cryptos) // set helperview datas
      self?.refreshControl?.endRefreshing() // end animation
      self?.activityIndicator.stopAnimating() // end animation
      self?.activityIndicator.isHidden = true // hide indicator
    }
  }
  
  @objc
  func callPullToRefresh() {
    viewModel.refreshDatas()
  }
}
//MARK: - Delegation Defined
extension MarketInfoViewController: MarketInfoDelegate {
  func didCryptoSelected(_ vc: UIViewController) {
    present(vc, animated: true)
  }
}
