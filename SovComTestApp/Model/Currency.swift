//
//  Currency.swift
//  SovComTestApp
//
//  Created by Yaroslav on 27.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

enum Currency: String, Codable {
    case USD = "USD"
    case CAD = "CAD"
    case GBP = "GBP"
    case AUD = "AUD"
    
    enum CodingKeys: String, CodingKey {
        case USD = "USD"
        case CAD = "CAD"
        case GBP = "GBP"
        case AUD = "AUD"
    }
}
