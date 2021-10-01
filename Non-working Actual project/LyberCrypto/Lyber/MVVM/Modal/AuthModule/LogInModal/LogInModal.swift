//
//  LogInModal.swift
//  Lyber
//
//  Created by Rahul's Mac on 25/09/21.
//

import Foundation


enum LogInErrorType {
    case email
    case password
}

struct LoginRequest {
    var email, password: String?
}
