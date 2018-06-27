//
//  ProductsViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/26/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ProductsViewController: UIViewController {
    
    /// MARK: Properties
    
    @IBOutlet var productTableView: UITableView!
    
    var viewModel: ProductViewModel? = nil
    var disposeBag = DisposeBag()
    
    // MARK: Constants
    
    struct Constants {
        static let viewControllerTitle = "Products"
        static let cellIdentifier = "productCellIdentifier"
    }
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.viewControllerTitle
        self.productTableView.alwaysBounceVertical = false
        
        self.viewModel = ProductViewModel()
        self.viewModel?.getProducts()
        bindTableView()
        onSelectedCell()
    }
    
    // MARK: table view data binding
    
    func bindTableView() {
        self.productTableView.tableFooterView = UIView()
        
        // MARK: error observable
        
        self.viewModel?.error.asObservable().subscribe(onNext: { (errorMessage) in
            print(errorMessage)
            // TO DO
            // handle error
        }).disposed(by: disposeBag)
        
        // MARK: products observable
        
        self.viewModel?.products.asObservable().bind(to: self.productTableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: ProductCell.self)) { row, product, cell in

            self.setupCell(cell: cell, with: product)
        }.disposed(by: disposeBag)
    }
    
    // MARK: cell data binding
    
    func setupCell(cell: ProductCell, with product: Product) {
        let productImage = getImageFromString(stringImage: product.imageURL)
        cell.productImage.image = productImage
        cell.productName.text = product.name
    }
    
    // MARK: fetch image
    
    func getImageFromString(stringImage: String) -> UIImage {
        let imageURL = URL(string: stringImage)
        do {
            let imageData = try Data(contentsOf: imageURL!)
            return UIImage(data: imageData)!
        } catch  {
            return UIImage()
        }
    }
    
    func onSelectedCell() {
        self.productTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            
            guard (self?.productTableView.cellForRow(at: indexPath) as? ProductCell) != nil else {
                return
            }
            self?.productTableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
}
