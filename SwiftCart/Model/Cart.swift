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

    var total: Float {
        get {
            return self.products.reduce(0.0) {t, item in t + item.price}
        }
    }

    func add(product: Product) {
        self.products.append(product)
    }
}
