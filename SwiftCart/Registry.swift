//
//  Registry.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 07/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import Foundation

class Registry {

    static let instance = Registry();
    private init(){}

    lazy var cart: Cart = Cart()

}
