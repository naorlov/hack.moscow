//
//  UserModel.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 28/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {
    var userName: String?
    var userPassword: String?
    var userToken: UUID?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        userName <- map["user_name"]
        userPassword <- map["user_password"]
        userToken <- map["user_token"]
    }
}
