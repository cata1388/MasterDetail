//
//  Product.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/25/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

struct Location: Mappable {
    var longitude: Double?
    var latitude: Double?
    
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }
}

@objcMembers
class Product: Object, Mappable {
    
    // MARK: Properties
    
    dynamic var productId: Int = 0
    dynamic var name: String = ""
    dynamic var imageURL: String = ""
    dynamic var price: Double = 0.0
    dynamic var expirationDate: Date? = nil
    dynamic var creationDate: Date = Date()
    dynamic var location: Location? = nil
    
    
    /// MARK: Initializers
    
    convenience init(productId: Int, name: String, imageURL: String, price: Double, expirationDate: Date?, creationDate: Date, location: Location?) {
        self.init()
        
        self.productId = productId
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.expirationDate = expirationDate
        self.creationDate = creationDate
        self.location = location
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    // MARK: Mapper function
    
    func mapping(map: Map) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        productId <- map["productId"]
        name <- map["productName"]
        imageURL <- map["imageURL"]
        price <- map["price"]
        if let expirationDateString = map["expirationDate"].currentValue as? String,
            let date = formatter.date(from: expirationDateString) {
            expirationDate = date
        }
        
        if let creationDateString = map["creationDate"].currentValue as? String,
            let date = formatter.date(from: creationDateString) {
            creationDate = date
        }
        
        location <- map["location"]
    }
    
    static func getProducts(response: @escaping ([Product]?, String?) -> Void) {
        apiProvider.request(ServerAPI.getProducts()) { (serviceResponse) in
            switch serviceResponse {
            case .success(let moyaResponse):
                switch moyaResponse.statusCode {
                case 200:
                    do {
                        let products = Mapper<Product>().mapArray(JSONArray: try moyaResponse.mapJSON() as! [[String: Any]])
                        response(products, nil)
                    } catch let error {
                        response(nil, error.localizedDescription)
                    }
                default:
                    do {
                        let error = try moyaResponse.mapString(atKeyPath: "error")
                        response(nil, error)
                    } catch let error {
                        response(nil, error.localizedDescription)
                    }
                }
                
            case .failure(let moyaError):
                response(nil, moyaError.errorDescription)
            }
        }
    }
}


