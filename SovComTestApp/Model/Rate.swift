//
//  Rate.swift
//  SovComTestApp
//
//  Created by Yaroslav on 27.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import Combine


fileprivate struct Rate: Codable {
    private enum CodingKeys: String, CodingKey {
        case from, to, rate
    }
    
    var from: String
    var to: String
    var rate: String
}


class Rates {
    
    private var _rates: [Rate] = {
        let ratesDataURL = Bundle.main.url(forResource: "rates", withExtension: "plist")
        guard let ratesURL = ratesDataURL else { print("Files not found. Comeback later."); return [Rate]() }
        guard let ratesXMLData = try? Data(contentsOf: ratesURL) else { return [Rate]()}
        let decoder = PropertyListDecoder()
        guard let rates = try? decoder.decode([Rate].self, from: ratesXMLData) else { return [Rate]() }
        return rates
    }()
    
    func getRate(from: Currency, to: Currency) -> Double {
        // GBP -> GBP case
        if from == to { return 1.0 }
        
        let forward = _rates.filter{ $0.from == from.rawValue }.filter { $0.to == to.rawValue }
        
        // Easy case — rate could be found by direct comparing
        guard !forward.isEmpty,
            let rateObject = forward.first,
            let rate = Double(rateObject.rate) else {
            
                // Hard case — rate could be found by reverse comparing
                let backward = _rates.filter{ $0.from == to.rawValue }.filter { $0.to == from.rawValue }
                guard !backward.isEmpty,
                    let rateObject = backward.first,
                    let rate = Double(rateObject.rate) else {
                        return 1.0
                }
                return 1.0 / rate
        }
        return rate
    }
    
}
