//
//  FxResponse.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 10/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

public struct FxResponse : Codable {
    var quotes : Dictionary<String,Float>
    var timestamp : Int64
}
