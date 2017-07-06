//
//  Cart.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 06/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

class Cart {

    private(set) var items : [CartItem] = []

    var total: Float {
        get { return items.reduce(0.0) { value, item in
                value + item.subTotal
            }
        }
    }

    var totalQuantity : Int {
        get { return items.reduce(0) { value, item in
                 value + item.quantity
            }
        }
    }

    func add(product: Product) {
        let foundItem = items.filter {$0.product == product}
        if foundItem.first != nil {
            foundItem.first!.quantity += 1
        } else {
            items.append(CartItem(product: product))
        }
    }
}
