//
//  Product.swift
//  SovComTestApp
//
//  Created by Yaroslav on 27.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

class Products: ObservableObject {
    
    @Published
    var products: [Product]
    
    init() {
        let transactionsDataURL = Bundle.main.url(forResource: "transactions", withExtension: "plist")
        guard let transactionURL = transactionsDataURL else { self.products = [Product](); return }
        guard let transactionsXMLData = try? Data(contentsOf: transactionURL) else { self.products = [Product](); return }
        let decoder = PropertyListDecoder()
        guard let transactions = try? decoder.decode([Transaction].self, from: transactionsXMLData) else { self.products = [Product](); return }
        var products = [Product]()
        
        for item in transactions {
            guard !products.contains(where: { $0.sku == item.sku} ) else {
                continue }
            var product = Product(from: item)
            let productTransactions = transactions.filter {$0.sku == product.sku}
            guard !productTransactions.isEmpty else { continue }
            product.append(transactions: productTransactions)
            products.append(product)
        }
        self.products = products
    }
    
}

struct Product: Identifiable {
    var id: String
    var sku: String { return id }
    private (set) var transactions: [Transaction]
    
    fileprivate init(from raw: Transaction) {
        self.id = raw.sku
        self.transactions = [raw]
    }
    
    fileprivate mutating func append(transactions: [Transaction]) {
        self.transactions.append(contentsOf: transactions)
    }
    
    var totalAmount: Double {
        transactions.reduce(0) { sum, transaction in
            sum + transaction.amountInGBP
        }
    }
}


class Transaction: Codable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case _sku = "sku"
        case _amount = "amount"
        case _currency = "currency"
    }
    
    private var _sku: String
    private var _amount: String
    private var _currency: String
    
    var id = UUID()
    var sku: String { return _sku }
    var initialAmount: Double { return Double(_amount) ?? 0 }
    var currency: Currency { return Currency.init(rawValue: _currency) ?? .GBP}
    var amountInGBP: Double {
        let rates = Rates()
        return initialAmount * rates.getRate(from: (Currency(rawValue: _currency) ?? .GBP), to: .GBP)
    }
    
}


