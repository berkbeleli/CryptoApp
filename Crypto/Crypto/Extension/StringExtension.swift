//
//  StringExtension.swift
//  Crypto
//
//  Created by Berk Beleli on 2022-06-08.
//

import Foundation
extension String{
    var htmlStripped : String{ // this will allow to remove html codes from string
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
