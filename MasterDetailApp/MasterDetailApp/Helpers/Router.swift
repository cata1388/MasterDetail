//
//  Router.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/26/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import Moya


// MARK: API baseURL

struct ServiceURL {
    #if DEBUG
    static let base = "http://www.mocky.io/v2/5b344fed3200001d0cd1e36c"
    
    #else
    static let base = "http://www.mocky.io/v2/5b344fed3200001d0cd1e36c"
    
    #endif
}

// MARK: API Targets

enum ServerAPI {
    case getProducts()
}

// MARK: API Provider - this provider will build the request

var apiProvider = MoyaProvider<ServerAPI>()

// MARK: Target extension - this will contain all the information to build the request

extension ServerAPI: TargetType {
    
    var headers: [String: String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: ServiceURL.base)!
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var path: String {
        switch self {
        case .getProducts():
            return "/products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts():
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getProducts():
            return  .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getProducts():
            return """
            [{"productId": 45, "name": "Pencil", "imageURL": "https://images.clipartlogo.com/files/images/47/470660/pencil-clip-art_f.jpg", "price": 1.5, "expirationDate": null, "creationDate": "2018-04-17T15:23:11.000Z", "location": { "longitude": -75.559085, "latitude": 6.23779}}]
            """.data(using: .utf8)!
        }
    }
}
