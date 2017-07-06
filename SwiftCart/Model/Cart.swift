//
//  Cart.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 06/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

class Cart {

    fileprivate var products : [Product] = []
    fileprivate var items : [CartItem] = []

    var total: Float {
        get {
            return self.items.reduce(0.0) { value, item in value + item.subTotal }
        }
    }

    var totalQuantity : Int {
        get {
            return self.items.reduce(0) { q, item in q + item.quantity }
        }
    }

    func add(product: Product) {
        let foundItem = self.items.filter {$0.product == product}
        if foundItem.first != nil {
            foundItem.first!.quantity += 1
        } else {
            let newItem : CartItem = CartItem(product: product)
            items.append(newItem)
        }
    }
}
