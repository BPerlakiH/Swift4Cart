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

    var totalInCurrency : String {
        get { return String.init(format: "%.2f", fx.priceOf(price: cart.total, inCurrency: selectedCurrency)) }
    }

    var currentRate : String? {
        get {
            if let rate = fx.rateOf(currency: selectedCurrency) {
                return String.init(format: "%.2f", rate)
            } else {
                return nil
            }
        }
    }

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelSubTotal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        //initially set the picker value to the selected currency
        currencyPicker.selectRow(fx.activeCurrencies.index(of: selectedCurrency)! , inComponent: 0, animated: false)

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fx.refresh {
            updateView()
        }
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        if selectedCurrency == "USD" {
            labelSubTotal.text = ""
        } else {
            labelSubTotal.text = "\(cart.total) @ \(currentRate ?? "---")"
        }
        labelTotal.text = totalInCurrency
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

extension CartViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItemCell", for: indexPath)
        let cartItem = cart.items[indexPath.item]
        let product = cartItem.product
        cell.textLabel?.text = product.name
        let displayPrice = "\(cartItem.quantity) * \(product.price)"
        cell.detailTextLabel?.text = displayPrice
        return cell
    }
}


extension CartViewController : UITableViewDelegate {
    
}

