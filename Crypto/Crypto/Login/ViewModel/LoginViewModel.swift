//
//  LoginViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-14.
//

import Foundation

protocol LoginViewProtocol: AnyObject { // Protocol Definition
  func success()
  func bothError()
  func emailError()
  func passwordError()
}

class LoginViewModel {
  weak var delegate: LoginViewProtocol?
  func loginClicked(email: String, password: String) {
    if email.count == 0 && password.count == 0 {
      delegate?.bothError() // if both are empty call
    }else if email.count == 0 {
      delegate?.emailError()// if one empty call
    }else if password.count == 0 {
      delegate?.passwordError() // if one empty call
    }else {
      delegate?.success() //  if success
    }
  }
}
