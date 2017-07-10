//
//  Product.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 06/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

struct Product: Codable, Equatable {

    var name: String
    var price: Float
    var unit: String

    // MARK: Equatable
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.unit == rhs.unit
    }

    func displayUnit(quantity: Int) -> String {
        return quantity == 1 ? unit : unit + "s"
    }
}
