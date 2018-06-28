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
    var expirationDate: String? = nil
    var creationDate: String = ""
    
    struct Constants {
        static let viewControllerTitle = "Product Detail"
        static let mapViewSegueIdentifier = "mapViewSegueIdentifier"
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
        
        if expirationDate == nil {
            expirationDateStackView.isHidden = true
        }
    }
    
    // MARK: Navigation management
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case Constants.mapViewSegueIdentifier:
            guard let mapViewController = segue.destination as? MapViewController else { return }
            
            mapViewController.productLocation = productLocation
        default:
            break
        }
    }
}
