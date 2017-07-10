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

    func refresh(completion: () -> Void) {
        let downloader = FXDownloader()
        downloader.downloadRates(apiKey: apiKey, currencies: activeCurrencies) { (data, error) in
            if let _ = error {
                NSLog("other api error", error.debugDescription)
                return
            }

            guard let jsonData = data else {
                NSLog("no data has been returned")
                return
            }
            let decoder = JSONDecoder()
            self.response = try? decoder.decode(FxResponse.self, from: jsonData)
        }
    }

    func rateOf(currency: String) -> Float? {
        assert(currency.count == 3)
        assert(activeCurrencies.contains(currency))
        return self.response?.quotes["USD\(currency)"]
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
