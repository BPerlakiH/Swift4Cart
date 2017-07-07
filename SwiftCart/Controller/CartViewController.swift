//
//  SecondViewController.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 05/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    let cart : Cart = Registry.instance.cart
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        labelTotal.text = "\(cart.total)"
    }

}

extension CartViewController : UIPickerViewDataSource {

    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }

    
}

