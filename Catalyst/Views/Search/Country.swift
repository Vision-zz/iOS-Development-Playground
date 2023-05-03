//
//  Country.swift
//  Catalyst
//
//  Created by Sathya on 07/03/23.
//

import Foundation
import UIKit

struct Country: Decodable {
    var name: String
    var code: String
    var capital: String?
    var continent: String
    var subregion: String?
    var languages: [String]?
    var flag: String
    var timezones: [String]
    var area: String
}
