//
//  ProductsViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/26/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewController: UIViewController {
    
    /// MARK: Properties
    
    @IBOutlet var productTableView: UITableView!
    
    var viewModel: ProductViewModel? = nil
    
    // MARK: Constants
    
    struct Constants {
        static let viewControllerTitle = "Products"
    }
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.viewControllerTitle
        self.productTableView.alwaysBounceVertical = false
        
        self.viewModel = ProductViewModel()
        self.viewModel?.getProducts()
        bindTableView()
    }
    
    // MARK:
    func bindTableView() {
        self.viewModel?.products.asObservable().subscribe(onNext: { (productList) in
            print(productList)
        })
    }
}
