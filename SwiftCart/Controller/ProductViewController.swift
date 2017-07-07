//
//  FirstViewController.swift
//  SwiftCart
//
//  Created by Balazs Perlaki-Horvath on 05/07/2017.
//  Copyright © 2017 perlakidigital. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController {

    fileprivate let cart : Cart = Registry.instance.cart
    fileprivate let insets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 64.0, right: 16.0)
    fileprivate let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    fileprivate let products:[Product] = Products().all()
    fileprivate let reuseID = "ProductCell"
    fileprivate let itemsPerRow: CGFloat = 2

    @IBOutlet weak var buttonNavToCart: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //update subviews on cart content changes
    func updateViews() {
        //update Checkout nav button title
        buttonNavToCart.title = (0 < cart.totalQuantity) ? "Checkout (\(cart.totalQuantity))" : "Checkout"
    }

}

//MARK: DataSource / Delegate
extension ProductViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("selected: %i", indexPath.item)
        let selectedProduct = products[indexPath.item]
        cart.add(product: selectedProduct)
        updateViews()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! ProductCellView
        cell.title.text = products[indexPath.item].name
        cell.price.text = String.init(format: "$ %.02f", products[indexPath.item].price)
        let imgName = products[indexPath.item].name.lowercased() + ".jpg"
        let img = UIImage(named: imgName)
        let imgView = UIImageView.init(image: img)
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        cell.backgroundView = imgView
        return cell
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension ProductViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = insets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem*1.309)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

