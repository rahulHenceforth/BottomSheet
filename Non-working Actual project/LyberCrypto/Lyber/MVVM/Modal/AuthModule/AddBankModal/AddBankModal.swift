//
//  AddBankModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation

enum AddBankErrorType {
    case name
    case cardNum
    case expiry
    case cvv
}

struct AddBankRequest {
    var name, cardNum, expiry, cvv: String!
}
