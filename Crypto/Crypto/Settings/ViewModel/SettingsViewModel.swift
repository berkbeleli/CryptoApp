//
//  SettingsViewModel.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-14.
//

import Foundation
// protocol definition
protocol SettingsViewProtocol: AnyObject {
  func onWebsiteSelected()
}

class SettingsViewModel {
  weak var delegate: SettingsViewProtocol?
  /// This function set the website LinkedIn
  func linkedInSelected() { // set linkedIn if selected website is LinkedIN
    ContactWebsites.setCurrentWebsite = ContactWebsites.linkedIn
    delegate?.onWebsiteSelected() // call delegation func
  }
  /// This function set the website github
  func gitHubSelected() {// set github if selected website is github
    ContactWebsites.setCurrentWebsite = ContactWebsites.gitHub
    delegate?.onWebsiteSelected()  // call delegation func
  }
}
