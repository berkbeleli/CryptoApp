//
//  DetailViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-06.
//

import UIKit
import Charts

class DetailViewController: UIViewController {
  // Object connections
  @IBOutlet private weak var coinImageVView: UIImageView!
  @IBOutlet private weak var coinNumber: UILabel!
  @IBOutlet private weak var coinNameLabel: UILabel!
  @IBOutlet private weak var coinShortNameLabel: UILabel!
  @IBOutlet private weak var currentPriceLabel: UILabel!
  @IBOutlet private weak var changeImageView: UIImageView!
  @IBOutlet private weak var changePercentageLabel: UILabel!
  @IBOutlet private weak var addToPortfolioButton: UIButton!
  @IBOutlet private weak var chartView: LineChartView!
  @IBOutlet private weak var descriptionHeaderLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var marketCapLabel: UILabel!
  @IBOutlet private weak var totalVolumeLabel: UILabel!
  @IBOutlet private weak var lastdayHighLabel: UILabel!
  @IBOutlet private weak var lastdayLowLabel: UILabel!
  @IBOutlet private weak var maxSupplyLabel: UILabel!
  @IBOutlet private weak var totalSupplyLabel: UILabel!
  @IBOutlet private weak var circulatingSupplyLabel: UILabel!
  @IBOutlet private weak var alltimeHighLabel: UILabel!
  @IBOutlet private weak var allTimeLowLabel: UILabel!
  
  var coinName: String? // it will hold received coinName
  private var viewModel = DetailViewModel() // initialization of viewmodel
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchSpecificCoinDatas(coinName ?? "bitcoin") // call coinDatas
    setupUI()
  }
  
  func setupUI() {
    addToPortfolioButton.layer.cornerRadius = 5
    viewModel.delegate = self
    
    viewModel.onSpecificCoinLoaded = { [weak self] specificCoinDatas in
      self?.updateUI(specificCoinDatas) // updateview according to received datas
      if self?.viewModel.checkItemInPortfolio(specificCoinDatas.id ?? "")  ?? false{ // checek if item in portfolio
        self?.addToPortfolioButton.tintColor = .darkGray
        self?.addToPortfolioButton.backgroundColor = .white
      }
    }
  }
  
  func updateUI(_ model: SpecificViewViewModel) {
    let url = URL(string: (model.image!))
    coinImageVView.kf.setImage(with: url)
    coinNumber.text = model.marketCapRank
    coinNameLabel.text = model.name
    coinShortNameLabel.text = model.symbol
    currentPriceLabel.text = model.currentPrice
    changeImageView.image = Double(model.priceChangePercentage ?? "0.0")! > 0.0 ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill")
    changeImageView.tintColor = Double(model.priceChangePercentage ?? "0.0")! > 0.0 ? .green : .red
    changePercentageLabel.text = "\(model.priceChangePercentage!) %"
    changePercentageLabel.textColor = Double(model.priceChangePercentage ?? "0.0")! > 0.0 ? .green : .red
    marketCapLabel.text =  model.marketCap
    totalVolumeLabel.text = model.totalVolume
    lastdayHighLabel.text = model.high24h
    lastdayLowLabel.text =  model.low24h
    maxSupplyLabel.text =  model.maxSupply
    totalSupplyLabel.text = model.totalSupply
    circulatingSupplyLabel.text = model.circulatingSupply
    alltimeHighLabel.text =  model.ath
    allTimeLowLabel.text = model.atl
    descriptionHeaderLabel.text = "About \(model.name!):"
    descriptionLabel.text = model.description!.htmlStripped
    self.updateGraph(model.lineDatas ?? [])
  }
  /// Update the graph
  func updateGraph(_ prices: [Double]) {
    let data = viewModel.createGraphLines(prices)
    chartView.data = data // set graph datas
    chartView.rightAxis.enabled = false // remove right axiscdatas
    chartView.xAxis.labelTextColor = .clear
    chartView.animate(xAxisDuration: 2.0, easingOption: .linear) // give animation to graph
    chartView.leftYAxisRenderer.axis?.labelTextColor = .white
    chartView.legend.enabled = false // remove graph's bottom explanations
    chartView.legend.textColor = .white
  }
  
  @IBAction func addToPortforlioButtonClicked(_ sender: UIButton) {
    viewModel.addToPortfolioClicked()
  }
}
//MARK: - Protocol Definition
extension DetailViewController: DetailViewProtocol {
  func addedToPortfolio() {
    UIView.animate(withDuration: 0.5) {
      self.addToPortfolioButton.tintColor = .darkGray
      self.addToPortfolioButton.backgroundColor = .white
    }
  }
  
  func deletedFromPortfolio() {
    UIView.animate(withDuration: 0.5) {
      self.addToPortfolioButton.tintColor = .white
      self.addToPortfolioButton.backgroundColor = .clear
    }
  }
}
