//
//  PersonalInfoModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation

enum PersonalInfoErrorType {
    case fullName
    case citizenship
    case city
    case zipCode
    case dob
}

struct PersonalInfoRequest {
    var fullName, citizenship, city, zipCode, dob: String!
}
