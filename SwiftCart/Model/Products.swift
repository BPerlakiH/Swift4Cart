//
//  Products.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 05/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

class Products {

    struct Product: Codable {
        var name: String
        var price: Float
        var unit: String
    }

    func getAll () -> [Product] {
        let decoder = JSONDecoder()
        if let products = try? decoder.decode([Product].self, from: _getJsonData()) {
            return products
        }
        return []
    }

    private func _getJsonData () -> Data {
        let productsData = """
        [
            {
                "name": "Peas",
                "price": 0.95,
                "unit": "bag"
            },
            {
                "name": "Eggs",
                "price": 2.10,
                "unit": "dozen"
            },
            {
                "name": "Milk",
                "price": 1.30,
                "unit": "bottle"
            },
            {
                "name": "Beans",
                "price": 0.73,
                "unit": "can"
            }
        ]
        """.data(using: .utf8)!
        return productsData
    }
}
