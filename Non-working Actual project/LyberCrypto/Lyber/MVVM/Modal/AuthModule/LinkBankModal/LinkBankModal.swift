//
//  LinkBankModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation

enum LinkBankErrorType {
    case name
    case accountNum
    case routingNum
    case address
    case postalCode
}

struct LinkBankRequest {
    var name, accountNum, routingNum, address, postalCode: String!
}
