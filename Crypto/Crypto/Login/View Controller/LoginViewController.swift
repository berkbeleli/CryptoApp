//
//  LoginViewController.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-14.
//

import UIKit

class LoginViewController: UIViewController {
  //Create Object Connections
  @IBOutlet private weak var backgroundView: UIImageView!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  
  private var viewModel = LoginViewModel() //  viewModel initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Setup UI
    }
    
  func setupUI() {
    viewModel.delegate = self // set viewmodel's delegate to ourselves
    backgroundView.layer.cornerRadius = 10
    signInButton.layer.cornerRadius = 10
    emailTextField.setIcon(UIImage(systemName: "envelope")!) // set textfield icon
    passwordTextField.setIcon(UIImage(systemName: "lock")!)// set textfield icon
    emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]) // change textfield placeholder color
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]) // change textfield placeholder color
  }
  
  @IBAction func signInClicked(_ sender: UIButton) {
    viewModel.loginClicked(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") // call view model function accordiing to our textfield's values
  }
}

extension LoginViewController: LoginViewProtocol {
  func success() {
    emailTextField.layer.borderColor = UIColor.clear.cgColor // change border color
    emailTextField.layer.borderWidth = 0 // change border width
    passwordTextField.layer.borderColor = UIColor.clear.cgColor // change border color
    passwordTextField.layer.borderWidth = 0 // change border width
    if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
      let navVC = vc.viewControllers![0] as! SettingsViewController
      navVC.email = emailTextField.text
      vc.modalPresentationStyle = .fullScreen
      self.present(vc, animated: true)
    }
  }
  
  func bothError() {
    emailTextField.layer.borderColor = UIColor.red.cgColor // change border color
    emailTextField.layer.borderWidth = 3 // change border width
    passwordTextField.layer.borderColor = UIColor.red.cgColor // change border color
    passwordTextField.layer.borderWidth = 3 // change border width
  }
  
  func emailError() {
    passwordTextField.layer.borderColor = UIColor.clear.cgColor // change border color
    passwordTextField.layer.borderWidth = 0 // change border width
    emailTextField.layer.borderColor = UIColor.red.cgColor // change border color
    emailTextField.layer.borderWidth = 3 // change border width
  }
  
  func passwordError() {
    emailTextField.layer.borderColor = UIColor.clear.cgColor // change border color
    emailTextField.layer.borderWidth = 0
    passwordTextField.layer.borderColor = UIColor.red.cgColor // change border color
    passwordTextField.layer.borderWidth = 3 // change border width
  }
}

