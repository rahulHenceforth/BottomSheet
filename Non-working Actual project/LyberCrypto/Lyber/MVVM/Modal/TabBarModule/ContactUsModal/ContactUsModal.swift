//
//  ContactUsModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation


enum ContactUsErrorType {
    case subject
    case msg
}

struct ContactUsRequest {
    var subject, msg : String!
}
