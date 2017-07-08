//
//  SecondViewController.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 05/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    let fx : FX = FX()
    let cart : Cart = Registry.instance.cart
    var selectedCurrency = "USD"

    var totalInCurrency : Float {
        get { return fx.priceOf(price: cart.total, inCurrency: selectedCurrency) }
    }

    var currentRate : Float {
        get { return fx.rateOf(currency: selectedCurrency) }
    }

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelSubTotal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        fx.refresh()
        if selectedCurrency == "USD" {
            labelSubTotal.text = ""
        } else {
            labelSubTotal.text =
        """
            USD \(cart.total) @ \(currentRate)
        """
        }
        labelTotal.text = "\(totalInCurrency)"
    }

}

extension CartViewController : UIPickerViewDataSource {

    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fx.activeCurrencies.count
    }
}

extension CartViewController : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fx.activeCurrencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = fx.activeCurrencies[row]
        updateView()
    }
}

