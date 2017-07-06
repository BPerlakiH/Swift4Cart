//
//  CartItem.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 06/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

class CartItem {

    var quantity : Int = 1
    var product : Product

    var subTotal : Float { get { return product.price * Float(quantity) } }

    init(product: Product) {
        self.product = product
    }


}
