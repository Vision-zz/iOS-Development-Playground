//
//  Country.swift
//  Catalyst
//
//  Created by Sathya on 07/03/23.
//

import Foundation
import UIKit

struct Country: Decodable {
    struct Currency: Decodable {
        var code: String
        var name: String
        var symbol: String?
    }

    struct Language: Decodable {
        var code: String
        var name: String
    }

    var name: String
    var code: String
    var capital: String
    var region: String
    var currency: Currency
    var language: Language
    var flag: String
    var diallingCode: String
    var isoCode: String

}
