//
//  ProductTests.swift
//  SwiftCartTests
//
//  Created by Balazs Perlaki-Horvath on 05/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import XCTest

class ProductTests: XCTestCase {

    
    func testProductCount() {
        let products = Products().all()
        XCTAssertEqual(products.count, 4)
    }

    func testProductPrices() {
        let products = Products().all()
        XCTAssertEqual(products.first?.price, 0.95, "a bag of peas should cost 0.95")
        XCTAssertEqual(products[1].price, 2.1, "a dozen of eggs should cost 2.10")
        XCTAssertEqual(products[2].price, 1.3, "a bottle of milk should cost 1.30")
        XCTAssertEqual(products.last?.price, 0.73, "a can of beans should cost 0.73")
    }

    func testProductNames() {
        let products = Products().all()
        let expectedNames = ["peas", "eggs", "milk", "beans"]
        for (index, expName) in expectedNames.enumerated() {
            XCTAssert(products[index].name.lowercased() == expName, "product should be named: \(expName)")
        }
    }

    func testProductUnits() {
        let products = Products().all()
        let expectedUnits = ["bag", "dozen", "bottle", "can"]
        for (index, expUnit) in expectedUnits.enumerated() {
            XCTAssert(products[index].unit.lowercased() == expUnit, "product should have a unit: \(expUnit)")
        }
    }
    
}
