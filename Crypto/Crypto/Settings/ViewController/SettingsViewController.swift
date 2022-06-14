//
//  SettingsViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-14.
//

import UIKit

class SettingsViewController: UIViewController {
  // Object Connections
  @IBOutlet private weak var appStackView: UIStackView!
  @IBOutlet private weak var accountLabel: UILabel!
  @IBOutlet private weak var gitHubstackView: UIStackView!
  @IBOutlet private weak var gitHubLabel: UILabel!
  @IBOutlet private weak var linkedInStackView: UIStackView!
  @IBOutlet private weak var linkedInLabel: UILabel!
  @IBOutlet private weak var logOutButton: UIButton!
  
  var email: String? // define e-mail variable
  private var viewModel = SettingsViewModel() // viewmodel creation
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    viewModel.delegate = self // get delegate to our viewcontroller
    appStackView.layer.cornerRadius = 10 // set radius
    accountLabel.text = "Account    '\(email ?? "")'" // get entered email value and print it
    
    let tapGit = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFunctionGitHub)) // set a gesture a func
    gitHubLabel.addGestureRecognizer(tapGit)// give label tapGesture
    let tapLink = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFunctionLinkedIn))// set a gesture a func
    linkedInLabel.addGestureRecognizer(tapLink) // give label tapGesture
    gitHubstackView.clipsToBounds = true
    gitHubstackView.layer.cornerRadius = 10
    gitHubstackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // only make radius for top corners
    linkedInStackView.clipsToBounds = true
    linkedInStackView.layer.cornerRadius = 10
    linkedInStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] // only make radius for bottom corners
    logOutButton.layer.cornerRadius = 10 // set corner radius for button
  }
  
  @IBAction func tapFunctionGitHub(sender: UITapGestureRecognizer) {
    viewModel.gitHubSelected() // call viewmodel func according to our click
  }
  
  @IBAction func tapFunctionLinkedIn(sender: UITapGestureRecognizer) {
    viewModel.linkedInSelected() // call viewmodel func according to our click
  }
  
  @IBAction func logOutClicked(_ sender: UIButton) {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
  
}

extension SettingsViewController: SettingsViewProtocol {
  func onWebsiteSelected() {
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavController") // open website's navigation controller
    self.present(vc, animated: true)
  }
}
