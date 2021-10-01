//
//  SignUpModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 25/09/21.
//

import Foundation


enum SignUpErrorType {
    case firstName
    case lastName
    case email
    case password
    case referalCode
}

struct SignUpRequest {
    var firstName, lastName, email, password, referalCode: String?
}
