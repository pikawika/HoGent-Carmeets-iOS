//
//  Meeting.swift
//  CarMeets
//
//  Created by Lennert Bontinck on 31/12/2018.
//  Copyright © 2018 Lennert Bontinck. All rights reserved.
//

import Foundation

/**
 Een meeting object.
 */
struct Meeting: Codable {
    var meetingId: String
    
    var imageName: String
    
    var title: String
    var subtitle: String
    var description: String
    var date: Date
    
    var city: String
    var postalCode: String
    var streetName: String
    var houseNumber: String
    
    var categories: [String]
    var listUsersGoing: [String]
    var listUsersLiked: [String]
    
    //niet altijd meegegeven in backend
    var website: String?
    
    //makkelijker om dit als apart object te hebben in code
    func location() -> Location {
        return Location.init(city: self.city, postalCode: self.postalCode, streetName: self.streetName, houseNumber: self.houseNumber)
    }
    
    enum CodingKeys: String, CodingKey {
        case meetingId = "_id"
        
        case title = "name"
        case subtitle = "shortDescription"
        case description = "fullDescription"
        case date
        
        case imageName = "afbeeldingNaam"
        
        case city = "gemeente"
        case postalCode = "postcode"
        case streetName = "straatnaam"
        case houseNumber = "straatnr"
        
        case categories
        case listUsersGoing
        case listUsersLiked
        
        case website = "site"
    }
}
