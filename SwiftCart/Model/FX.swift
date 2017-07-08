//
//  FX.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 07/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation
import UIKit

class FX {

    struct FxResponse : Codable {
        var quotes : Dictionary<String,Float>
        var timestamp : Int64
    }

    let apiKey : String
    let activeCurrencies : [String]
    var response : FxResponse?

    init() {
        apiKey = Bundle.main.object(forInfoDictionaryKey: "FX_API_Key") as! String
        activeCurrencies = Bundle.main.object(forInfoDictionaryKey: "FX_Active_Currencies") as! [String]
    }

    func all() -> Dictionary<String, Float>? {
        return self.response?.quotes
    }

    func refresh() {
        let decoder = JSONDecoder()
        self.response = try? decoder.decode(FxResponse.self, from: _getJsonData())
        //dict2.forEach { (k,v) in dict1[k] = v }

//        for name:String in activeCurrencies {
//            self.quotes = Dictionary.map(self.response?.quot)
//            self.quotes[name] = self.response?.quotes["USD\(name)"]
//        }

//        if let respValue = try? decoder.decode(FxResponse.self, from: _getJsonData()) {
//            self.response = respValue
//            self.quotes = Dictionary<String, Float>(respValue.quotes, uniquingKeysWith: { (key, _) in key })
//            NSLog("quotes: %@", quotes)
//        } else {
//            self.response = nil
//            self.quotes = nil
//        }
    }

    func rateOf(currency: String) -> Float {
        assert(currency.count == 3)
        assert(activeCurrencies.contains(currency))
        return self.response!.quotes["USD\(currency)"]!
    }

    func priceOf(price: Float, inCurrency: String) -> Float {
        assert(inCurrency.count == 3)
        assert(inCurrency == "USD" || activeCurrencies.contains(inCurrency))
        if let rate = self.response?.quotes["USD\(inCurrency)"] {
            return rate * price
        } else {
            return price
        }
    }

    func _getJsonData() -> Data {
        let fxData = """
        {
            "success": true,
            "terms": "https://currencylayer.com/terms",
            "privacy": "https://currencylayer.com/privacy",
            "timestamp": 1499431446,
            "source": "USD",
            "quotes": {
                "USDAUD": 1.315016,
                "USDCAD": 1.291402,
                "USDCHF": 0.96167,
                "USDEUR": 0.87505,
                "USDGBP": 0.77495,
                "USDHUF": 269.619995,
                "USDPLN": 3.704299
            }
           }
        """.data(using: .utf8)!
        return fxData
    }

}
