//
//  FXTests.swift
//  SwiftCartTests
//
//  Created by Balazs Perlaki-Horvath on 07/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import XCTest

class FXTests: XCTestCase {
    
    func testConfiguration() {
        let fx = FX()
        XCTAssertNotNil(fx.apiKey)
        XCTAssertTrue(30 < fx.apiKey.count)

        XCTAssertNotNil(fx.activeCurrencies)
        XCTAssertFalse(fx.activeCurrencies.isEmpty)

        for currency:String in fx.activeCurrencies {
            XCTAssertEqual(currency.count, 3, "currency: \(currency) should have a 3 letter key")
        }
    }

    func testDownloadRates() {
        let fx = FX()
        XCTAssertNil(fx.all())
        fx.refresh()
        XCTAssertNotNil(fx.all())
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 1.0, inCurrency: "CHF"), 0.9, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 1.0, inCurrency: "EUR"), 0.8, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 1.0, inCurrency: "GBP"), 0.7, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 1.0, inCurrency: "PLN"), 3.7, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 1.0, inCurrency: "HUF"), 260, accuracy: 20)

        XCTAssertEqualWithAccuracy(fx.priceOf(price: 4.0, inCurrency: "EUR"), 3.2, accuracy: 0.4)
        XCTAssertEqualWithAccuracy(fx.priceOf(price: 10.0, inCurrency: "GBP"), 7.0, accuracy: 1)
    }

    func testAvailableCurrencies() {
        let fx = FX()
        fx.refresh()
        XCTAssertNotNil(fx.all()![""])
    }
    
}
