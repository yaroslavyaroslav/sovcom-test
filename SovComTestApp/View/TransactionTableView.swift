//
//  TransactionTableView.swift
//  SovComTestApp
//
//  Created by Yaroslav on 27.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import SwiftUI

struct TransactionTableView: View {

    var product: Product
    
    static func currencyFormat(currency: Currency) -> Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue
        return formatter
    }
    
    var body: some View {
        VStack {
            if product.transactions.isEmpty {
                Text("Sorry, no valid data provided.")
            } else {
                List {
                    Section(header: Text("Total: \(self.product.totalAmount as NSNumber, formatter: Self.currencyFormat(currency: Currency.GBP))")) {
                        ForEach(product.transactions) { transaction in
                            HStack {
                                Text("\(transaction.initialAmount as NSNumber, formatter: Self.currencyFormat(currency: transaction.currency))")
                                Spacer()
                                Text("\(transaction.amountInGBP as NSNumber, formatter: Self.currencyFormat(currency: Currency.GBP))")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("Transactions for \(product.sku)"), displayMode: .inline)
    }
}

struct TransactionTableView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyView()
//            TransactionTableView(transactions: devTransactions)
//            TransactionTableView(transactions: emptyTransactions)
        }
    }
}
