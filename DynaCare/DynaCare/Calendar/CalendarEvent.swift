//
//  CalendarEvent.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 28/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation

import ObjectMapper

class CalendarEvent: Mappable {

    var eventId: Int?;
    var drugId: Int?;
    var eventDate: Date?;
    var treatmentId: Int?;
    var eventType: String?;
    var analysis: String?;
    var patientId: Int?;
    var desc: String?;
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        eventId <- map["id"]
        drugId <- map["drug_id"]
        eventDate <- map["event_date"]
        treatmentId <- map["treatment_id"]
        eventType <- map["event_type"]
        analysis <- map["analysis"]
        patientId <- map["patient_id"]
        desc <- map["desc"]
    }
}
