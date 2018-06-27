//
//  ProductDetailViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/27/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productExpirationDateLabel: UILabel!
    @IBOutlet var productCreationDateLabel: UILabel!
    @IBOutlet var expirationDateStackView: UIStackView!
    var productLocation: Location? = nil
    
    var image: UIImage = UIImage()
    var name: String = ""
    var price: String = ""
    var expirationDate: String = ""
    var creationDate: String = ""
    
    struct Constants {
        static let viewControllerTitle = "Product Detail"
    }
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.viewControllerTitle
        
        productImage.image = image
        productNameLabel.text = name
        productPriceLabel.text = price
        productExpirationDateLabel.text = expirationDate
        productCreationDateLabel.text = creationDate
        
        if expirationDate == "" {
            expirationDateStackView.isHidden = true
        }
    }
    
    // MARK: Actions
    
    @IBAction func productLocationTouchUpInside(_ sender: Any) {
        //TO DO
        // show product location
    }
    
}
