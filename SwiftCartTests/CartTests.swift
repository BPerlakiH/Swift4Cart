//
//  CartTests.swift
//  SwiftCartTests
//
//  Created by Balazs Perlaki-Horvath on 06/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import XCTest

//{
//    "name": "Peas",
//    "price": 0.95,
//    "unit": "bag"
//},
//{
//    "name": "Eggs",
//    "price": 2.10,
//    "unit": "dozen"
//},
//{
//    "name": "Milk",
//    "price": 1.30,
//    "unit": "bottle"
//},
//{
//    "name": "Beans",
//    "price": 0.73,
//    "unit": "can"
//}

class CartTests: XCTestCase {

    let products: [Product] = Products().all()
    var peas : Product { get { return products[0] } }
    var eggs : Product { get { return products[1] } }
    var milk : Product { get { return products[2] } }
    var beans : Product{ get { return products[3] } }

    func testEmptyCart() {
        let cart = Cart()
        XCTAssert(cart.total == 0, "empty cart shouldn't cost a dime")
    }

    func testAddingToCart() {
        let cart = Cart()
        cart.add(product: peas)
        XCTAssert(0 < cart.total, "the cart content should cost something")
        XCTAssert(cart.total == peas.price, "the price of peas should be in the cart")
    }
    
//    func testAddProduct() {
//        let cart = Cart()
//        cart.total
//        cart.add(peas)
//        XCTAssert(cart.total == peas.price, "cart to") cart.total
//    }

}
