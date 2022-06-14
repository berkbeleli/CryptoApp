//
//  SearchCoinViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-10.
//

import UIKit
import Kingfisher

class SearchCoinViewController: UIViewController {
  // object connections
  @IBOutlet private weak var searchCoinBar: UISearchBar!
  @IBOutlet private weak var ResultCountLabel: UILabel!
  @IBOutlet private weak var searchedCoinsTableView: UITableView!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  private var tableViewHelper: SearchCoinTableViewHelper! // tableview helper variable
  private var viewModel = SearchCoinViewModel() // viewmodel initialization
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    searchCoinBar.delegate = self
    setUpController()
  }
  
  func setUpController() {
    tableViewHelper = .init(with: searchedCoinsTableView, vm: viewModel) // tableviewhelper initialization
    tableViewHelper.delegate = self
    
    viewModel.fetchCryptos("") // get all cryptos firstly
    activityIndicator.isHidden = false
    activityIndicator.startAnimating() // start activity indicator's animation
    
    viewModel.onSearchItemsChanged = { [weak self] cryptos in
      self?.tableViewHelper.setItems(cryptos)
      self?.ResultCountLabel.text = "Results: \(cryptos.count)"
      self?.activityIndicator.stopAnimating()
      self?.activityIndicator.isHidden = true
    }
  }
  /// This function will change view of the searchBar
  func setupUI() {
    let searchTextField = searchCoinBar.value(forKey: "searchField") as? UITextField
    searchTextField?.textColor = .white
    searchTextField?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    searchTextField?.attributedPlaceholder =  NSAttributedString(string: "Search Coin", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    let glassIconView = searchTextField?.leftView as! UIImageView
    glassIconView.image = glassIconView.image
    glassIconView.tintColor = .white
    searchCoinBar.searchBarStyle = .minimal
  }
}

extension SearchCoinViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.fetchCryptos(searchText) // call the data fetch func according to user's entered text
  }
}

extension SearchCoinViewController: SearchCoinDelegate {
  func didCryptoSelected(_ vc: UIViewController) {
    present(vc, animated: true)
  }
}
