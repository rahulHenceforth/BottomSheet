//
//  Result.swift
//  Lyber
//
//  Created by Rahul's Mac on 25/09/21.
//

import Foundation

struct ValidationResult<T>{
    let success: Bool
    let errorMsg : String?
    var errorOnField: T? = nil
    
}
