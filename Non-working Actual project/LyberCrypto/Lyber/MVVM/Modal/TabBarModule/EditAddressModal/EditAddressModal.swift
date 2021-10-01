//
//  EditAddressModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation


enum EditAddressErrorType {
    case citizenship
    case city
    case zip
}

struct EditAddressRequest {
    var citizenship, city, zip : String!
}
