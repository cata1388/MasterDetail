//
//  ProductViewModel.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/26/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift
import RxCocoa
import RxSwift

class ProductViewModel: NSObject {
    
    // MARK: Properties
    
    var products = Variable<[Product]>([])
    var error = Variable<String>("")
    var disposeBag = DisposeBag()
    
    // MARK: function to get the products
    
    func getProducts() {
        Product.getProducts { (productsResponse, errorMessage) in
            
            guard let productList = productsResponse else {
                if let error = errorMessage {
                    Observable.just(error).bind(to: self.error).disposed(by: self.disposeBag)
                }
                return
            }
            
            Observable.just(productList).bind(to: self.products).disposed(by: self.disposeBag)
        }
    }
}
