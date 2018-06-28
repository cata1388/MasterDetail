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
        static let productDetailSegueIdentifier = "productDetailSegue"
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
    
    // MARK: selected cell
    
    func onSelectedCell() {
        self.productTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            
            guard (self?.productTableView.cellForRow(at: indexPath) as? ProductCell) != nil else {
                return
            }
            self?.productTableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: Navigation management
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        switch segue.identifier {
        case Constants.productDetailSegueIdentifier:
            guard let detailViewController = segue.destination as? ProductDetailViewController else { return}
            guard let indexPath = self.productTableView.indexPathForSelectedRow else { return }
            guard let product = self.viewModel?.products.value[indexPath.row] else { return }
            
            let image = self.getImageFromString(stringImage: (product.imageURL))
            
            detailViewController.image = image
            detailViewController.name = product.name
            detailViewController.price = String(describing: "$ \(product.price)")
            detailViewController.creationDate = dateFormatter.string(from: product.creationDate)
            detailViewController.productLocation = product.location
            
            if product.expirationDate != nil {
                detailViewController.expirationDate = dateFormatter.string(from: (product.expirationDate!))
            } else {
                detailViewController.expirationDate = nil
            }
        default:
            break
        }
    }
}
