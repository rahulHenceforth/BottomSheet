//
//  ChangePassModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation

enum ChangePassErrorType {
    case oldPass
    case newPass
}

struct ChangePassRequest {
    var oldPass, newPass : String!
}
