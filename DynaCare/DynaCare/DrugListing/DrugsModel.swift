//
//  DrugsModel.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 28/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation
import ObjectMapper

class DrugModel: Mappable {
    var drugId: Int?;
    var name: String?;
    var desc: String?;
    var activeIngridient: String?;
    var contradications: String?;
    var sideEffects: String?;
    var pictureURL: String?;
    
    required init(map: Map) {}
    
    func mapping(map: Map) {
        drugId <- map["id"]
        name <- map["name"]
        desc <- map["description"]
        activeIngridient <- map["active_ingridient"]
        contradications <- map["contradications"]
        sideEffects <- map["side_effects"]
        pictureURL <- map["pic_url"]
    }
}


import Foundation

struct Candy {
    let category : String
    let name : String
}
