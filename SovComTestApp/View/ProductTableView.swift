//
//  ProductTableView.swift
//  SovComTestApp
//
//  Created by Yaroslav on 27.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import SwiftUI

struct ProductTableView: View {
    
    @ObservedObject
    var productsInstance = Products()
    
    
    var body: some View {
        NavigationView{
            VStack {
                if productsInstance.products.isEmpty {
                    Text("Sorry, no valid data provided.")
                } else {
                    List(productsInstance.products) {product in
                        NavigationLink(destination: TransactionTableView(product: product)) {
                            HStack {
                                Text("\(product.sku)")
                                Spacer()
                                Text("\(product.transactions.count) transactions")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Produtcs"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyView()
//            ProductTableView(productsInstance: <#T##Products#>)
//            ProductTableView(items: devItems)
//            ProductTableView(items: emptyProducts)
        }
    }
}
