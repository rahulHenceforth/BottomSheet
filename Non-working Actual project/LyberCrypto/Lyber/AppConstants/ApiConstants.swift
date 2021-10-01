//
//  ApiConstants.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 16/09/21.
//

import Foundation

// MARK:- API ENVIORMENT
enum ApiEnviorment: String {
    case Dev = "http://139.59.47.49:7009/api/"
    case Stage = "http://192.168.0.181:8081/api/user/"
    case Live = "http://192.168.0.181:8082/api/user/"
    case swaggerUrl = "http://192.168.0.181:8082/api-docs"
}

// MARK:- IMAGE QUALITY
enum Image_Quality : String {
    case medium = "Medium"
    case small = "Small"
    case large = "Orig"
}

// MARK:- API URL'S CLASS
class NetworkURL {
    
    var BASE_URL: String{
        return ApiEnviorment.Dev.rawValue
    }
    
}

