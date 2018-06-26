//
//  Product.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/25/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit
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

class Product: Object, Mappable {
    
    // MARK: Properties
    
    dynamic var productId: Int = 0
    dynamic var name: String = ""
    dynamic var imageURL: String = ""
    dynamic var price: Double = 0.0
    dynamic var expirationDate: Date = Date()
    dynamic var creationDate: Date = Date()
    dynamic var location: Location? = Location(longitude: 0, latitude: 0)
    
    
    /// MARK: Initializers
    
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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
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
    
}
